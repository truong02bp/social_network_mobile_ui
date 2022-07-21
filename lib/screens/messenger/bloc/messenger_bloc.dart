import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/conversation_repository.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

part 'messenger_event.dart';
part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  StompClient? _stompClient;
  final ConversationRepository conversationRepository =
      ConversationRepository.getInstance();

  MessengerBloc() : super(MessengerState()) {
    _onInitialEvent();
    _onGetConversationEvent();
    _onReceiveMessageEvent();
  }

  _onInitialEvent() {
    on<MessengerInitialEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      state.conversations.clear();
      state.page = 0;
      state.limit = 15;
      state.user = event.user;
      _stompClient = StompClient(
        config: StompConfig(
            url: 'ws://$IP:$port/ws-social-network',
            onConnect: (StompFrame frame) {},
            stompConnectHeaders: {'Authorization': '$token'},
            onWebSocketError: (dynamic error) => print(error.toString())),
      );
      _stompClient!.activate();
      add(GetConversationEvent());
    });
  }

  _onGetConversationEvent() {
    on<GetConversationEvent>((event, emit) async {
      int userId = state.user!.id;
      List<Conversation> conversations =
          await conversationRepository.getConversation(
              userId: userId, page: state.page, limit: state.limit);
      if (conversations.isNotEmpty) {
        state.conversations.addAll(conversations);
        state.page++;
        emit(state.clone(MessengerStatus.getConversationSuccess));
        conversations.forEach((conversation) {
          _stompClient!.subscribe(
              destination: '/topic/${conversation.id}',
              callback: (StompFrame frame) {
                Message message = Message.fromJson(jsonDecode(frame.body!));
                add(ReceiveMessageEvent(message: message));
              });
        });
      }
    });
  }

  _onReceiveMessageEvent() {
    on<ReceiveMessageEvent>((event, emit) {
      final conversation = state.conversations.firstWhere(
          (element) => element.id == event.message.sender.conversationId);
      conversation.lastMessage = event.message;
      state.conversations.remove(conversation);
      state.conversations.insert(0, conversation);
      state.conversationUpdated = conversation;
      emit(state.clone(MessengerStatus.receiveMessage));
    });
  }
}
