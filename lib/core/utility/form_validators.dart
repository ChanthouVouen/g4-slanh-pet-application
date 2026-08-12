import 'package:slanh_pet_application/core/constants/register/register_string.dart';

abstract class FormValidators {
  static String? validateRegistration({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required bool isAgreed,
    required bool isCustomer,
    String? shopName,
    String? shopAddress,
  }) {
    if (fullName.trim().isEmpty) {
      return RegisterString.fullNameRequired;
    }
    if (email.trim().isEmpty) {
      return RegisterString.emailRequired;
    }
    // Simple email pattern check
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return RegisterString.emailInvalid;
    }
    if (phone.trim().isEmpty) {
      return RegisterString.phoneRequired;
    }
    if (!isCustomer) {
      if (shopName == null || shopName.trim().isEmpty) {
        return RegisterString.shopNameRequired;
      }
      if (shopAddress == null || shopAddress.trim().isEmpty) {
        return RegisterString.shopAddressRequired;
      }
    }
    if (password.length < 6) {
      return RegisterString.passwordTooShort;
    }
    if (password != confirmPassword) {
      return RegisterString.passwordMismatch;
    }
    if (!isAgreed) {
      return RegisterString.agreeTermsRequired;
    }
    return null;
  }

  static String? validateLogin({
    required String email,
    required String password,
  }) {
    if (email.trim().isEmpty) {
      return 'Please enter your email address.';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email address.';
    }

    if (password.trim().isEmpty) {
      return 'Please enter your password.';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    return null;
  }
}
