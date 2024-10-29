import 'package:hive/hive.dart';
part  '../providers/services.g.dart';
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

  Service({
    required this.typeId,
    required this.typeName,
    required this.typeImageUrl,
    required this.typeDescription,
    required this.serviceStatus,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      typeId: json['type_id'],
      typeName: json['type_name'],
      typeImageUrl: json['type_image_url'],
      typeDescription: json['type_description'] ?? '',
      serviceStatus: json['service_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'type_name': typeName,
      'type_image_url': typeImageUrl,
      'type_description': typeDescription,
      'service_status': serviceStatus,
    };
  }
}
