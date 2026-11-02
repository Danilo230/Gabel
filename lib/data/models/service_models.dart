
class ServiceModels {
  final int serviceId;
  final String serviceName;
  final double servicePrice;
  final bool serviceStatus;
  final String serviceDescription;
  final int? stylistId;
  final String stylistName;

  ServiceModels({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceStatus,
    required this.serviceDescription,
    this.stylistId,
    required this.stylistName,
  });

  static ServiceModels fromJson(Map<String, dynamic> json) {
    return ServiceModels(
      serviceId: json['serviceId'] as int,
      serviceName: json['serviceName'] as String,
      servicePrice: (json['servicePrice'] as num).toDouble(),
      serviceStatus: json['serviceStatus'] as bool,
      serviceDescription: json['serviceDescription'] as String,
      stylistId: json['stylistId'] as int?,
      stylistName: json['stylistName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'serviceStatus': serviceStatus,
      'serviceDescription': serviceDescription,
      'stylistId': stylistId,
      'stylistName': stylistName,
    };
  }
}
