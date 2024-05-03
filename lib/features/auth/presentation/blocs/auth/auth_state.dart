import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

// class GoogleSignInState extends AuthState {}

// class FacebookSignInState extends AuthState {}

// class PhoneSignInState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String? message;
  ErrorAuthState({this.message});
  @override
  List<Object> get props => [message!];
}

class ChangeUserInfoState extends AuthState {}
// class LoggedOutState extends AuthState {}

class AuthorizedState extends AuthState {
  UserEntity? user;
  AuthorizedState({this.user});
  @override
  List<Object> get props => [user!];
}

class UnauthorizedState extends AuthState {}

class IsOTPVerified extends AuthState {
  String verificationId;
  IsOTPVerified({required this.verificationId});
  @override
  List<Object> get props => [verificationId!];
}
