// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    username: json['username'] as String,
    email: json['email'] as String,
    adress: json['adress'] as String,
    tel: json['tel'] as String,
    img: json['img'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'adress': instance.adress,
      'tel': instance.tel,
      'img': instance.img,
    };
