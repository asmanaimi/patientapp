// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    username: json['username'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
    id: json['_id'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'token': instance.token,
      'password': instance.password,
      '_id': instance.id,
    };
