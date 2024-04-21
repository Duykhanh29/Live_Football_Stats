import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {super.authOption,
      super.email,
      super.phoneNumber,
      super.photo,
      super.userID,
      super.userName});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'authOption': AuthOptionValues.reverse[authOption],
      'email': email,
      'phoneNumber': phoneNumber,
      'photo': photo,
      'userID': userID,
      'userName': userName
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        authOption: json["authOption"] != null
            ? AuthOptionValues.map[json["authOption"]]
            : null,
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        photo: json['photo'],
        userID: json['userID'],
        userName: json['userName']);
  }
  UserEntity toEntity() {
    return UserEntity(
        authOption: authOption,
        email: email,
        phoneNumber: phoneNumber,
        photo: photo,
        userID: userID,
        userName: userName);
  }
}
