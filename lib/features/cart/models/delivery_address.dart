class DeliveryAddress {
  const DeliveryAddress({this.name = '', this.phone = '', this.address = ''});

  final String name;
  final String phone;
  final String address;

  bool get isComplete => address.trim().isNotEmpty;

  DeliveryAddress copyWith({String? name, String? phone, String? address}) {
    return DeliveryAddress(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
