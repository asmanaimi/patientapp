// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddOrdoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrdoModel _$AddOrdoModelFromJson(Map<String, dynamic> json) {
  return AddOrdoModel(
    medecin: json['medecin'] as String,
    email: json['email'] as String,
    priseencharge: json['priseencharge'] as String,
    id: json['_id'] as String,
    technicien: json['technicien'] as String,
    status: json['status'] as String,
    listp: json['listp'] as String,
    coverImage: json['coverImage'] as String,
  );
}

Map<String, dynamic> _$AddOrdoModelToJson(AddOrdoModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'medecin': instance.medecin,
      'priseencharge': instance.priseencharge,
      'listp': instance.listp,
      'coverImage': instance.coverImage,
      'technicien': instance.technicien,
      'status': instance.status,
      '_id': instance.id,
    };
