import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository})
      : super(HomeLoaded(
          users: UserModel.getFallbackProfiles(),
          currentIndex: 0,
          selectedUser: UserModel.getFallbackProfiles().first,
        )) {
    on<LoadHomeUsers>(_onLoadHomeUsers);
    on<RefreshHomeUsers>(_onRefreshHomeUsers);
    on<SwipeLeftUser>(_onSwipeLeftUser);
    on<SwipeRightUser>(_onSwipeRightUser);
    on<UndoSwipeUser>(_onUndoSwipeUser);
    on<SelectUserForDetail>(_onSelectUserForDetail);
    on<SendComplimentEvent>(_onSendCompliment);
  }

  Future<void> _onLoadHomeUsers(
    LoadHomeUsers event,
    Emitter<HomeState> emit,
  ) async {
    // If state doesn't have users, emit loading
    if (state is! HomeLoaded || (state as HomeLoaded).users.isEmpty) {
      emit(const HomeLoading());
    }

    try {
      final users = await userRepository.getHomeUsers();
      if (users.isNotEmpty) {
        emit(HomeLoaded(
          users: users,
          currentIndex: 0,
          selectedUser: users.first,
        ));
      } else {
        final fallback = UserModel.getFallbackProfiles();
        emit(HomeLoaded(
          users: fallback,
          currentIndex: 0,
          selectedUser: fallback.first,
        ));
      }
    } catch (e) {
      if (state is! HomeLoaded) {
        final fallback = UserModel.getFallbackProfiles();
        emit(HomeLoaded(
          users: fallback,
          currentIndex: 0,
          selectedUser: fallback.first,
        ));
      }
    }
  }

  Future<void> _onRefreshHomeUsers(
    RefreshHomeUsers event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final users = await userRepository.getHomeUsers();
      if (users.isNotEmpty) {
        emit(HomeLoaded(
          users: users,
          currentIndex: 0,
          selectedUser: users.first,
        ));
      }
    } catch (e) {
      // Keep existing data on refresh error
    }
  }

  void _onSwipeLeftUser(
    SwipeLeftUser event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      if (current.currentIndex < current.users.length) {
        final currentPerson = current.users[current.currentIndex];
        final nextIndex = current.currentIndex + 1;
        emit(current.copyWith(
          currentIndex: nextIndex,
          swipedHistory: [...current.swipedHistory, currentPerson],
          selectedUser: nextIndex < current.users.length
              ? current.users[nextIndex]
              : null,
          clearToast: true,
        ));
      }
    }
  }

  void _onSwipeRightUser(
    SwipeRightUser event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      if (current.currentIndex < current.users.length) {
        final currentPerson = current.users[current.currentIndex];
        final nextIndex = current.currentIndex + 1;
        emit(current.copyWith(
          currentIndex: nextIndex,
          swipedHistory: [...current.swipedHistory, currentPerson],
          selectedUser: nextIndex < current.users.length
              ? current.users[nextIndex]
              : null,
          clearToast: true,
        ));
      }
    }
  }

  void _onUndoSwipeUser(
    UndoSwipeUser event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      if (current.canUndo) {
        final history = List<UserProfile>.from(current.swipedHistory);
        history.removeLast();
        final prevIndex = current.currentIndex - 1;
        emit(current.copyWith(
          currentIndex: prevIndex,
          swipedHistory: history,
          selectedUser: current.users[prevIndex],
          clearToast: true,
        ));
      }
    }
  }

  void _onSelectUserForDetail(
    SelectUserForDetail event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(current.copyWith(selectedUser: event.user, clearToast: true));
    }
  }

  void _onSendCompliment(
    SendComplimentEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(current.copyWith(
        notificationToast:
            '🌹 ${event.giftType} + Comment sent! Opening chat...',
      ));
    }
  }
}
