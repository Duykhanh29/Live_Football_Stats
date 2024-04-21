import 'package:equatable/equatable.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';

class UserEntity extends Equatable {
  String? userName;
  String? userID;
  String? email;
  String? phoneNumber;
  String? photo;
  AuthOption? authOption;
  UserEntity(
      {this.authOption,
      this.email,
      this.phoneNumber,
      this.photo,
      this.userID,
      this.userName});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [userID, userName, authOption, phoneNumber, email, photo];
}
