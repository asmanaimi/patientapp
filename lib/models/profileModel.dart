

import 'package:json_annotation/json_annotation.dart';
part 'profileModel.g.dart';

@JsonSerializable()

class ProfileModel {
  String username;
String email;
  String adress;
  String tel;
String img;
  ProfileModel(
      {this.username,
      this.email,
      this.adress,
      this.tel,
      this.img,
    });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
