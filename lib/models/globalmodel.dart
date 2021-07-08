import 'package:json_annotation/json_annotation.dart';
import 'package:patientapp/models/AddOrdoModel.dart';
part 'globalmodel.g.dart';
@JsonSerializable()

// ignore: camel_case_types
class globalmodel{
  
List<AddOrdoModel> data;
  globalmodel(
      {
     this.data
    });
 factory globalmodel.fromJson(Map<String, dynamic> json) =>
      _$globalmodelFromJson(json);
  Map<String, dynamic> toJson() => _$globalmodelToJson(this);
}