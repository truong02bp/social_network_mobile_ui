import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageState()) {
    _onInitialEvent();
  }

  _onInitialEvent() {
    on<MessageInitialEvent>((event, emit) {
      final message = event.message;
      final conversation = event.conversation;
      state.message = message;
      state.conversation = conversation;
      state.isSender = message.sender.id == conversation.user.id;
      state.color = getColor(conversation.color);
      emit(state.clone(status: MessageStatus.initial));
    });
  }
}
