class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.photoUrl,
    this.dateOfBirth,
    this.bio,
    this.gender,
  });

  final String name;
  final String email;
  final String phone;
  final String role;
  final String? photoUrl;
  final String? dateOfBirth;
  final String? bio;
  final String? gender;

  factory ProfileModel.fromMap(Map<String, dynamic> map, {String? authEmail}) {
    final fullName = (map['fullName'] as String?)?.trim();
    return ProfileModel(
      name: fullName?.isNotEmpty == true ? fullName! : 'Pet lover',
      email: authEmail ?? (map['email'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? 'Add your phone number',
      role: (map['role'] as String?) ?? 'customer',
      photoUrl: map['photoUrl'] as String?,
      dateOfBirth: map['dateOfBirth'] as String?,
      bio: map['bio'] as String?,
      gender: map['gender'] as String?,
    );
  }
}
