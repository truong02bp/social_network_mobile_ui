
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial()) {
    on<PersonalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
