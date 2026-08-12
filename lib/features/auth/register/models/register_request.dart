class RegisterRequest {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String? gender;
  final String? shopName;
  final String? shopAddress;

  const RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.gender,
    this.shopName,
    this.shopAddress,
  });

  Map<String, dynamic> toUserProfileFieldsMap() {
    return {
      'fullName': fullName,
      'gender': gender,
      'phone': phone,
    };
  }

  Map<String, dynamic>? toShopFieldsMap() {
    if (role != 'seller') return null;

    return {
      'shopName': shopName,
      'shopAddress': shopAddress,
    };
  }
}
