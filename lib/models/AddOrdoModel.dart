
import 'package:json_annotation/json_annotation.dart';
part 'AddOrdoModel.g.dart';
@JsonSerializable()

class AddOrdoModel{
  
String email;
  String medecin;
  String priseencharge;
String coverImage;
  AddOrdoModel(
      {
        this.medecin,
      this.email,
      this.priseencharge,
     
      this.coverImage, String selectedType,
    });
 factory AddOrdoModel.fromJson(Map<String, dynamic> json) =>
      _$AddOrdoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddOrdoModelToJson(this);
}
