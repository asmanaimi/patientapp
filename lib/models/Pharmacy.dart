
import 'package:json_annotation/json_annotation.dart';
part 'Pharmacy.g.dart';
@JsonSerializable()

class Pharmacy{
  
  String id;
  String adress;
  String namepharma;
Pharmacy({this.id, this.adress,this.namepharma});

 factory Pharmacy.fromJson(Map<String, dynamic> json) =>
      _$PharmacyFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
}