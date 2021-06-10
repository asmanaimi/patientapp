

import 'package:json_annotation/json_annotation.dart';
part 'profileModel.g.dart';
@JsonSerializable()

class ProfileModel {
  String username;

  String adress;
  String tel;

  ProfileModel(
      {this.username,
      this.adress,
      this.tel,
    });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
