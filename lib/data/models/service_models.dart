class ServiceModels {
  final int serviceId;
  final String serviceName;
  final String servicePrice;
  final String serviceStilist;
  final String serviceDescription;
  final bool serviceStatus;

  ServiceModels({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceStilist,
    required this.serviceDescription,
    required this.serviceStatus,
  });

  factory ServiceModels.fromJson(Map<String, dynamic> json) {
    return ServiceModels(
      serviceId: json['serviceId'] as int,
      serviceName: json['serviceName'] as String,
      servicePrice: json['servicePrice'] as String,
      serviceStilist: json['serviceStilist'] as String,
      serviceDescription: json['serviceDescription'] as String,
      serviceStatus: json['serviceStatus'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'serviceStilist': serviceStilist,
      'serviceDescription': serviceDescription,
      'serviceStatus': serviceStatus,
    };
  }
}
