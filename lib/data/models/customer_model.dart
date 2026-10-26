class CustomerModel {
  final int customerId;
  final String customerName;
  final String customerLastName;
  final String customerStatus;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.customerStatus,
  });
  
  static CustomerModel fromJson(Map<String, dynamic> json){
    return CustomerModel(
      customerId: json['customerId'] as int,
      customerName: json['customerName'] as String,
      customerLastName: json['customerLastName'] as String,
      customerStatus: json['customeStatus'] as String,
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'customerId': customerId,
      'customerName': customerName,
      'customerLastName': customerLastName,
      'customerStatus': customerStatus,
    }
  }
}
