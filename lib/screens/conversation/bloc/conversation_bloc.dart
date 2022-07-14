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

  ConversationBloc() : super(ConversationState()) {
    _onInitialEvent();
    _onTypingEvent();
    _onSendTextMessageEvent();
    _onGetMessageEvent();
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
      print(messengerId);
      MessageDto textMessage = MessageDto(
          content: event.content,
          messengerId: messengerId,
          type: MessageType.TEXT);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      print(token);
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
      _stompClient = StompClient(
        config: StompConfig(
            url: 'ws://$IP:$port/ws-social-network',
            onConnect: (StompFrame frame) {
              print('connect success');
              _stompClient!.subscribe(
                  destination: '/topic/${conversation.id}',
                  callback: (StompFrame frame) {
                    print(jsonDecode(frame.body!));
                  });
            },
            stompConnectHeaders: {'Authorization': '$token'},
            onWebSocketError: (dynamic error) => print(error.toString())),
      );
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
