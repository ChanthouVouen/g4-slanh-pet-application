class ClinicModel {
  final String id;
  final String name;
  final String address;
  final String picture;

  ClinicModel({
    required this.id,
    required this.name,
    required this.address,
    required this.picture,
  });

  factory ClinicModel.fromMap(Map<String, dynamic> map) {
    return ClinicModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      picture: map['picture'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ClinicModel(id: $id, name: $name, address: $address)';
  }
}

class ServiceModel {
  final String id;
  final String clinicId;
  final String name;
  final String description;
  final double price;
  final String picture;
  final double rating;
  final ClinicModel clinic;

  ServiceModel({
    required this.id,
    required this.clinicId,
    required this.name,
    required this.description,
    required this.price,
    required this.picture,
    required this.rating,
    required this.clinic,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] ?? '',
      clinicId: map['clinic_id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      picture: (map['picture'] ?? 0).toString(),
      rating: (map['rating'] ?? 0),
      clinic: ClinicModel.fromMap(map['clinic'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, price: \$${price}, clinic: ${clinic.toString()})';
  }
}
