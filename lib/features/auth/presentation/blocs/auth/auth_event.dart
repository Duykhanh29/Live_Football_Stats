import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInWithGoogle extends AuthEvent {}

class SignInWithPhone extends AuthEvent {
  String phone;
  SignInWithPhone({required this.phone});
  @override
  // TODO: implement props
  List<Object?> get props => [phone];
}

class SignInWithFacebook extends AuthEvent {}

class GetCurrentUserEvent extends AuthEvent {}

class SignOut extends AuthEvent {}

class IsLoginEvent extends AuthEvent {}

class UpdateUser extends AuthEvent {
  UserEntity userEntity;
  UpdateUser({required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];
}

class OtpVerify extends AuthEvent {
  String verificationId, userOtp;
  OtpVerify({required this.userOtp, required this.verificationId});
  @override
  // TODO: implement props
  List<Object?> get props => [userOtp, verificationId];
}
