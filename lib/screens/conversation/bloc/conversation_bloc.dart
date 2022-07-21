import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/dto/message_dto.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/repositories/message_repository.dart';
import 'package:social_network_mobile_ui/ultils/time_ultil.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  StompClient? _stompClient;
  MessageRepository messageRepository = MessageRepository.getInstance();
  bool isConnected = false;

  ConversationBloc() : super(ConversationState()) {
    _onInitialEvent();
    _onTypingEvent();
    _onSendTextMessageEvent();
    _onGetMessageEvent();
    _onReceiveMessageEvent();
    _onUpdateMessageEvent();
    _onUpdateSeenMessageEvent();
  }

  _onReceiveMessageEvent() {
    on<ReceiveMessageEvent>((event, emit) {
      state.messages.insert(0, event.message);
      state.message = event.message;
      emit(state.clone(status: ConversationStatus.receiveMessage));
    });
  }

  _onGetMessageEvent() {
    on<GetMessageEvent>((event, emit) async {
      int page = state.page;
      int conversationId = state.conversation!.id;
      int limit = state.limit;
      List<Message> messages = await messageRepository.getMessage(
          conversationId: conversationId, page: page, limit: limit);
      state.messages.addAll(messages);
      state.page++;
      emit(state.clone(status: ConversationStatus.getMessageSuccess));
    });
  }

  _onSendTextMessageEvent() {
    on<SendTextMessageEvent>((event, emit) async {
      int messengerId = state.conversation!.user.id;
      MessageDto textMessage = MessageDto(
          content: event.content,
          messengerId: messengerId,
          type: MessageType.TEXT);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      _stompClient!.send(
          destination: "/social-network/message/send",
          body: jsonEncode(textMessage),
          headers: {'Authorization': token!});
    });
  }

  _onInitialEvent() {
    on<ConversationInitialEvent>((event, emit) async {
      final conversation = event.conversation;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      // connect socket
      if (_stompClient == null) {
        _stompClient = StompClient(
          config: StompConfig(
            url: 'ws://$IP:$port/ws-social-network',
            reconnectDelay: Duration(microseconds: 0),
            onConnect: (StompFrame frame) {
              _stompClient!.subscribe(
                  destination: '/topic/update/seen',
                  callback: (StompFrame frame) {
                    List<Message> messages = jsonDecode(frame.body!)
                        .map<Message>((json) => Message.fromJson(json))
                        .toList();
                    if (messages.isNotEmpty) {
                      add(UpdateSeenMessageEvent(messages: messages));
                    }
                  });
              _stompClient!.subscribe(
                  destination: '/topic/update/reaction',
                  callback: (StompFrame frame) {
                    Message message = Message.fromJson(jsonDecode(frame.body!));
                    add(UpdateMessageReactionEvent(message: message));
                  });
              _stompClient!.subscribe(
                  destination: '/topic/${conversation.id}',
                  callback: (StompFrame frame) {
                    Message message = Message.fromJson(jsonDecode(frame.body!));
                    add(ReceiveMessageEvent(message: message));
                  });
              add(UpdateMessageEvent(
                  type: "seen",
                  messageDto:
                      MessageDto(messengerId: state.conversation!.user.id)));
            },
            stompConnectHeaders: {'Authorization': '$token'},
          ),
        );
      }
      _stompClient!.activate();
      state.conversation = conversation;
      state.isActive =
          conversation.isGroup ? true : conversation.guests.first.user.isOnline;
      String timeOff =
          getTimeOnlineString(time: conversation.guests.first.user.lastOnline);
      if (timeOff.isNotEmpty) {
        state.leave = timeOff;
      }
      state.name = findName(conversation);
      add(GetMessageEvent());
      emit(state.clone(status: ConversationStatus.initial));
    });
  }

  _onTypingEvent() {
    on<ConversationTypingEvent>((event, emit) {
      if (state.isTyping != event.isTyping) {
        state.isTyping = event.isTyping;
        emit(state.clone(status: ConversationStatus.typing));
      }
    });
  }

  _onUpdateMessageEvent() {
    on<UpdateMessageEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      final headers = {'Authorization': '$token'};
      // while (!isConnected) {
      //   print(isConnected);
      // }

      if (event.type == "seen")
        _stompClient!.send(
            destination: "/social-network/message/update/seen",
            body: jsonEncode(event.messageDto),
            headers: headers);
      else if (event.type == "reaction") {
        _stompClient!.send(
            destination: "/social-network/message/update/reaction",
            body: jsonEncode(event.messageDto),
            headers: headers);
      }
    });
  }

  _onUpdateSeenMessageEvent() {
    on<UpdateSeenMessageEvent>((event, emit) async {
      if (state.messages.isNotEmpty &&
          state.messages[0].sender.id == state.conversation!.user.id) {
        state.messages.replaceRange(0, event.messages.length, event.messages);
        emit(state.clone(status: ConversationStatus.updateSeenSuccess));
      }
    });
  }

  String findName(Conversation conversation) {
    if (conversation.isGroup && conversation.name != null) {
      return conversation.name!;
    }
    final messenger = conversation.guests.first;
    if (messenger.nickName != null) {
      return messenger.nickName!;
    }
    return messenger.user.name;
  }
}
