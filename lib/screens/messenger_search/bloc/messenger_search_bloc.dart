import 'package:bloc/bloc.dart';

import 'messenger_search_event.dart';
import 'messenger_search_state.dart';

class MessengerSearchBloc extends Bloc<MessengerSearchEvent, MessengerSearchState> {
  MessengerSearchBloc() : super(MessengerSearchState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<MessengerSearchState> emit) async {
    emit(state.clone());
  }
}
