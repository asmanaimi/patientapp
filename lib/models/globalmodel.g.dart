// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globalmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

globalmodel _$globalmodelFromJson(Map<String, dynamic> json) {
  return globalmodel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AddOrdoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$globalmodelToJson(globalmodel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
