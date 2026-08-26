class ServiceModel {
  final String name;
  final String descripton;
  final String picture;
  final double price;
  final String clinic;

  ServiceModel({
    required this.name,
    required this.descripton,
    required this.picture,
    required this.price,
    required this.clinic,
  });

  // Convert a ServiceModel into a Map object to upload to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': descripton,
      'picture': picture,
      'clinic': clinic,
    };
  }
}
