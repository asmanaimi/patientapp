import 'package:json_annotation/json_annotation.dart';
part 'UserModel.g.dart';
@JsonSerializable()

class UserModel{
  
String email;
  String username;
  String token;
  String password;


@JsonKey(name: "_id")
  String id;
 UserModel(
      {
        this.username,
      this.email,
      this.token,
           this.id,
this.password,

//       String selectedType,
    });
 factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}