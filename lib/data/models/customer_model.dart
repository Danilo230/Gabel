class CustomerModel {
  final int customerId;
  final String customerName;
  final String customerLastName;
  final bool customerStatus;
  final String customerPhone;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.customerStatus,
    required this.customerPhone,
  });

  static CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customerId'] as int,
      customerName: json['customerName'] as String,
      customerLastName: json['customerLastName'] as String,
      customerPhone: json['customerPhone'] as String,
      customerStatus: json['customerStatus'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerLastName': customerLastName,
      'customerPhone': customerPhone,
      'customerStatus': customerStatus,
    };
  }
}
