// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupabaseUser _$SupabaseUserFromJson(Map<String, dynamic> json) => SupabaseUser(
      id: json['id'] as String?,
      userName: json['username'] as String,
      companyName: json['companyname'] as String,
    );

Map<String, dynamic> _$SupabaseUserToJson(SupabaseUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'companyname': instance.companyName,
    };
