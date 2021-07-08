// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListPharmacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPharmacy _$ListPharmacyFromJson(Map<String, dynamic> json) {
  return ListPharmacy(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Pharmacy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListPharmacyToJson(ListPharmacy instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
