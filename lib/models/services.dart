import 'package:hive/hive.dart';
part '../providers/services.g.dart';

@HiveType(typeId: 6)
class Service {
  @HiveField(0)
  final String typeId;
  @HiveField(1)
  final String typeName;
  @HiveField(2)
  final String typeImageUrl;
  @HiveField(3)
  final String typeDescription;
  @HiveField(4)
  final String serviceStatus;

  // Make cities field nullable
  @HiveField(5)
  final List<City>? cities;

  Service({
    required this.typeId,
    required this.typeName,
    required this.typeImageUrl,
    required this.typeDescription,
    required this.serviceStatus,
    this.cities,
  });

  factory Service.fromJson(Map<String, dynamic> json, List<dynamic>? citiesJson) {
    return Service(
      typeId: json['type_id'] as String,
      typeName: json['type_name'] as String,
      typeImageUrl: json['type_image_url'] as String,
      typeDescription: json['type_description'] ?? '',
      serviceStatus: json['service_status'] as String,
      cities: citiesJson?.map((cityJson) => City.fromJson(cityJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'type_name': typeName,
      'type_image_url': typeImageUrl,
      'type_description': typeDescription,
      'service_status': serviceStatus,
      'cities': cities?.map((city) => city.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 8)
class City {
  @HiveField(0)
  final String cityId;
  @HiveField(1)
  final String cityName;
  @HiveField(2)
  final String cityImage;
  @HiveField(3)
  final String cityStatus;

  City({
    required this.cityId,
    required this.cityName,
    required this.cityImage,
    required this.cityStatus,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'] as String,
      cityName: json['city_name'] as String,
      cityImage: json['city_image'] ?? '',
      cityStatus: json['city_status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'city_name': cityName,
      'city_image': cityImage,
      'city_status': cityStatus,
    };
  }
}