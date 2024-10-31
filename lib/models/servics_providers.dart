import 'package:hive/hive.dart';
part '../providers/servics_providers.g.dart';
@HiveType(typeId: 7)
class Officer {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String typeId;
  @HiveField(2)
  final String cityId;
  @HiveField(3)
  final String providerName;
  @HiveField(4)
  final String providerContact;
  @HiveField(5)
  final String cost;
  @HiveField(6)
  final String providerImageUrls;
  @HiveField(7)
  final String latLong;
  @HiveField(8)
  final String serviceDescription;
  @HiveField(9)
  final String typeName;
  @HiveField(10)
  final String cityName;

  Officer({
    required this.id,
    required this.typeId,
    required this.cityId,
    required this.providerName,
    required this.providerContact,
    required this.cost,
    required this.providerImageUrls,
    required this.latLong,
    required this.serviceDescription,
    required this.typeName,
    required this.cityName,
  });

  factory Officer.fromJson(Map<String, dynamic> json) {
    return Officer(
      id: json['id'] ?? '',
      typeId: json['type_id'] ?? '',
      cityId: json['city_id'] ?? '',
      providerName: json['provider_name'] ?? '',
      providerContact: json['provider_contact'] ?? '',
      cost: json['cost'] ?? '',
      providerImageUrls: json['provider_image_urls'] ?? '',
      latLong: json['latlong'] ?? '',
      serviceDescription: json['service_description'] ?? '',
      typeName: json['type_name'] ?? '',
      cityName: json['city_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_id': typeId,
      'city_id': cityId,
      'provider_name': providerName,
      'provider_contact': providerContact,
      'cost': cost,
      'provider_image_urls': providerImageUrls,
      'latlong': latLong,
      'service_description': serviceDescription,
      'type_name': typeName,
      'city_name': cityName,
    };
  }
}