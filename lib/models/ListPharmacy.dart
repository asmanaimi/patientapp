import 'package:json_annotation/json_annotation.dart';
import 'package:patientapp/models/Pharmacy.dart';
part 'ListPharmacy.g.dart';
@JsonSerializable()

// ignore: camel_case_types
class ListPharmacy{
  
List<Pharmacy> data;

  ListPharmacy(
      {
     this.data
    });
 factory ListPharmacy.fromJson(Map<String, dynamic> json) =>
      _$ListPharmacyFromJson(json);
  Map<String, dynamic> toJson() => _$ListPharmacyToJson(this);
}