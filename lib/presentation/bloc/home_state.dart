import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<UserProfile> users;
  final int currentIndex;
  final List<UserProfile> swipedHistory;
  final UserProfile? selectedUser;
  final String? notificationToast;

  const HomeLoaded({
    required this.users,
    this.currentIndex = 0,
    this.swipedHistory = const [],
    this.selectedUser,
    this.notificationToast,
  });

  UserProfile? get currentUser {
    if (currentIndex >= 0 && currentIndex < users.length) {
      return users[currentIndex];
    }
    return null;
  }

  bool get canUndo => swipedHistory.isNotEmpty && currentIndex > 0;

  HomeLoaded copyWith({
    List<UserProfile>? users,
    int? currentIndex,
    List<UserProfile>? swipedHistory,
    UserProfile? selectedUser,
    String? notificationToast,
    bool clearToast = false,
  }) {
    return HomeLoaded(
      users: users ?? this.users,
      currentIndex: currentIndex ?? this.currentIndex,
      swipedHistory: swipedHistory ?? this.swipedHistory,
      selectedUser: selectedUser ?? this.selectedUser,
      notificationToast:
          clearToast ? null : (notificationToast ?? this.notificationToast),
    );
  }

  @override
  List<Object?> get props => [
        users,
        currentIndex,
        swipedHistory,
        selectedUser,
        notificationToast,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
