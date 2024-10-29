import 'package:hive/hive.dart';

part '../providers/dealer.g.dart'; // Correct the part directive to match the file name

@HiveType(typeId: 5) // Unique typeId for Dealer
class Dealer {
  @HiveField(0)
  final String dealerId;

  @HiveField(1)
  final String dealerName;

  @HiveField(2)
  final String urDealerName;

  @HiveField(3)
  final String dealerAddress;

  @HiveField(4)
  final String urDealerAddress;

  @HiveField(5)
  final String dealerContact;

  @HiveField(6)
  final String geoLocation;

  @HiveField(7)
  final String isDeleted;

  Dealer({
    required this.dealerId,
    required this.dealerName,
    required this.urDealerName,
    required this.dealerAddress,
    required this.urDealerAddress,
    required this.dealerContact,
    required this.geoLocation,
    required this.isDeleted,
  });

  // Factory method to create Dealer object from JSON
  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      dealerId: json['dealer_id'],
      dealerName: json['dealer_name'],
      urDealerName: json['ur_dealer_name'] ?? '',
      dealerAddress: json['dealer_address'] ?? '',
      urDealerAddress: json['ur_dealer_address'] ?? '',
      dealerContact: json['dealer_contact'] ?? '',
      geoLocation: json['geo_location'] ?? '',
      isDeleted: json['is_deleted'] ?? '0',
    );
  }

  // Method to convert Dealer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'dealer_id': dealerId,
      'dealer_name': dealerName,
      'ur_dealer_name': urDealerName,
      'dealer_address': dealerAddress,
      'ur_dealer_address': urDealerAddress,
      'dealer_contact': dealerContact,
      'geo_location': geoLocation,
      'is_deleted': isDeleted,
    };
  }
}
