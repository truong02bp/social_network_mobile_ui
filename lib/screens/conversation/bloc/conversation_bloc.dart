import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/ultils/time_ultil.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationState()) {
    _onInitialEvent();
    _onTypingEvent();
  }

  _onInitialEvent() {
    on<ConversationInitialEvent>((event, emit) {
      final conversation = event.conversation;
      state.conversation = conversation;
      state.isActive =
          conversation.isGroup ? true : conversation.guests.first.user.isOnline;
      String timeOff =
          getTimeOnlineString(time: conversation.guests.first.user.lastOnline);
      if (timeOff.isNotEmpty) {
        state.leave = timeOff;
      }
      state.name = findName(conversation);
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
