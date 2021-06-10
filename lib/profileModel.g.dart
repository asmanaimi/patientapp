// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    username: json['username'] as String,
    adress: json['adress'] as String,
    tel: json['tel'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'adress': instance.adress,
      'tel': instance.tel,
    };
