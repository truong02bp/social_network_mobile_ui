part of 'common_bloc.dart';

@immutable
abstract class CommonEvent {}

class UpdateOnlineEvent extends CommonEvent {}

class UpdateOfflineEvent extends CommonEvent {
  final bool isLogout;

  UpdateOfflineEvent({required this.isLogout});
}
