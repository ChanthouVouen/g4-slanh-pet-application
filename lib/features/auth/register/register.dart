import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/services/auth/auth_service.dart';
import 'package:slanh_pet_application/core/utility/form_validators.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/widgets/custom_gender_dropdown.dart';
import 'package:slanh_pet_application/core/widgets/customer_text_field.dart';
import 'package:slanh_pet_application/core/widgets/terms_checkbox.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';
import 'package:slanh_pet_application/features/home/home_page.dart';
import 'package:slanh_pet_application/core/widgets/password_text_field.dart';
import 'package:slanh_pet_application/core/constants/register/register_string.dart';

import './models/register_request.dart';
import './widgets/register_footer.dart';
import './widgets/role_toggle.dart';
import './widgets/shop_field.dart';

class RegisterScreen extends StatefulWidget {
  final AuthService? authService;
  const RegisterScreen({super.key, this.authService});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final AuthService _authService;

  bool isCustomer = true;
  bool isAgreed = false;
  bool isSubmitting = false;
  String? selectedGender;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authService = widget.authService ?? AuthService();
  }

  @override
  void dispose() {
    for (var controller in [
      _fullNameController,
      _emailController,
      _phoneController,
      _passwordController,
      _confirmPasswordController,
      _shopNameController,
      _shopAddressController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitRegistration() async {
    final validationError = FormValidators.validateRegistration(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      isAgreed: isAgreed,
      isCustomer: isCustomer,
      shopName: _shopNameController.text,
      shopAddress: _shopAddressController.text,
    );

    if (validationError != null) {
      UiHelpers.showSnackBar(context, validationError, isError: true);
      return;
    }

    setState(() => isSubmitting = true);

    final request = RegisterRequest(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text.trim(),
      role: isCustomer ? 'customer' : 'seller',
      gender: selectedGender,
      shopName: isCustomer ? null : _shopNameController.text.trim(),
      shopAddress: isCustomer ? null : _shopAddressController.text.trim(),
    );

    final result = await _authService.signUpUser(
      email: request.email,
      password: request.password,
      role: request.role,
      extraFields: request.toUserProfileFieldsMap(),
      shopFields: request.toShopFieldsMap(),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (result == 'success') {
      UiHelpers.showSnackBar(context, RegisterString.successMessage);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const HomePage()),
        (_) => false,
      );
    } else {
      UiHelpers.showSnackBar(
        context,
        result ?? RegisterString.genericError,
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        toolbarHeight: 72,
        leadingWidth: 56,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          RegisterString.appbarTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoleToggle(
                isCustomer: isCustomer,
                onChanged: (val) => setState(() => isCustomer = val),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: RegisterString.fullNameLabel,
                hintText: RegisterString.fullNameHintText,
                controller: _fullNameController,
              ),
              CustomGenderDropdown(
                value: selectedGender,
                onChanged: (val) => setState(() => selectedGender = val),
              ),
              CustomTextField(
                label: RegisterString.emailLabel,
                hintText: RegisterString.emailHintText,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                label: RegisterString.phoneLabel,
                hintText: RegisterString.phoneHitext,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              if (!isCustomer)
                ShopFields(
                  nameController: _shopNameController,
                  addressController: _shopAddressController,
                ),
              PasswordTextField(
                label: RegisterString.passwordLabel,
                controller: _passwordController,
                validator: (v) => (v == null || v.length < 6)
                    ? RegisterString.pwdValidateChar
                    : null,
              ),
              PasswordTextField(
                label: RegisterString.confirmPasswordLabel,
                controller: _confirmPasswordController,
                validator: (v) => v != _passwordController.text
                    ? RegisterString.confirmPwd
                    : null,
              ),
              TermsCheckbox(
                value: isAgreed,
                onChanged: (val) => setState(() => isAgreed = val ?? false),
              ),
              const SizedBox(height: 24),
              AuthSubmitButton(
                label: RegisterString.createAccountButton,
                isSubmitting: isSubmitting,
                onPressed: _submitRegistration,
              ),
              const SizedBox(height: 20),
              RegisterFooter(
                onTapSignIn: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
