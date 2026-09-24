import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeUsers extends HomeEvent {
  const LoadHomeUsers();
}

class RefreshHomeUsers extends HomeEvent {
  const RefreshHomeUsers();
}

class SwipeLeftUser extends HomeEvent {
  const SwipeLeftUser();
}

class SwipeRightUser extends HomeEvent {
  const SwipeRightUser();
}

class UndoSwipeUser extends HomeEvent {
  const UndoSwipeUser();
}

class SelectUserForDetail extends HomeEvent {
  final UserProfile user;

  const SelectUserForDetail(this.user);

  @override
  List<Object?> get props => [user];
}

class SendComplimentEvent extends HomeEvent {
  final String compliment;
  final String giftType;

  const SendComplimentEvent({
    required this.compliment,
    this.giftType = 'Rose',
  });

  @override
  List<Object?> get props => [compliment, giftType];
}
