class StylistModel {
  final int stylistId;
  final String stylistName;
  final String phoneNumber;
  final String identityCard;
  final bool stylistStatus;

  const StylistModel({
    required this.stylistId,
    required this.stylistName,
    required this.phoneNumber,
    required this.identityCard,
    required this.stylistStatus,
  });

  static StylistModel fromJson(Map<String, dynamic> json) {
    return StylistModel(
      stylistId: json['stylistId'] as int,
      stylistName: json['stylistName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      identityCard: json['identityCard'] as String,
      stylistStatus: json['stylistStatus'] as bool,
    );
  }
}
