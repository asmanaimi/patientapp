// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pharmacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) {
  return Pharmacy(
    id: json['id'] as String,
    adress: json['adress'] as String,
    namepharma: json['namepharma'] as String,
  );
}

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
      'id': instance.id,
      'adress': instance.adress,
      'namepharma': instance.namepharma,
    };
