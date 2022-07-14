import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/conversation_repository.dart';

part 'messenger_event.dart';
part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  final ConversationRepository conversationRepository =
      ConversationRepository.getInstance();

  MessengerBloc() : super(MessengerState()) {
    _onInitialEvent();
    _onGetConversationEvent();
  }

  _onInitialEvent() {
    on<MessengerInitialEvent>((event, emit) {
      state.conversations.clear();
      state.page = 0;
      state.limit = 15;
      state.user = event.user;
      add(GetConversationEvent());
    });
  }

  _onGetConversationEvent() {
    on<GetConversationEvent>((event, emit) async {
      int userId = state.user!.id;
      print(userId);
      List<Conversation> conversations =
          await conversationRepository.getConversation(
              userId: userId, page: state.page, limit: state.limit);
      if (conversations.isNotEmpty) {
        state.conversations.addAll(conversations);
        state.page++;
        emit(state.clone(MessengerStatus.getConversationSuccess));
      }
    });
  }
}
