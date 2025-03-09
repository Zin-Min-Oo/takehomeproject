import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/user_service.dart';

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load users from SharedPreferences
class LoadUsers extends UserEvent {}

// Fetch users from API and save to SharedPreferences
class FetchUsers extends UserEvent {}

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class UserInitial extends UserState {}

// Loading state
class UserLoading extends UserState {}

// Loaded state with user list
class UserLoaded extends UserState {
  final List<dynamic> users;

  UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

// Error state
class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<FetchUsers>(_onFetchUsers);
  }

  // Load users from SharedPreferences
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJsonString = prefs.getString('users');

      if (userJsonString != null) {
        List<dynamic> userList = jsonDecode(userJsonString);
        emit(UserLoaded(userList)); // Load users from SharedPreferences
      } else {
        emit(UserLoaded([])); // No data found
      }
    } catch (e) {
      emit(UserError("Failed to load users"));
    }
  }

  // Fetch users from API and save to SharedPreferences
  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      List<dynamic> userList = await userService.fetchUsers();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJsonString = jsonEncode(userList);
      await prefs.setString('users', userJsonString);

      emit(UserLoaded(userList)); // Update UI with new data
    } catch (e) {
      emit(UserError("Failed to fetch users from API"));
    }
  }
}
