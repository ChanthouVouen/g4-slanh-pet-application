import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/services/auth/auth_service.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/widgets/field_label.dart';
import 'package:slanh_pet_application/core/widgets/input_decoration_extensions.dart';
import 'package:slanh_pet_application/features/auth/forgot_password/forgot_password.dart';
import 'package:slanh_pet_application/features/auth/login/models/login_request.dart';
import 'package:slanh_pet_application/features/auth/register/register.dart';
import 'package:slanh_pet_application/core/widgets/password_text_field.dart';
import 'package:slanh_pet_application/features/home/home.dart';

import './widgets/login_footer.dart';
import './widgets/login_header.dart';
import './widgets/or_divider.dart';
import './widgets/socail_login_button.dart';

class LoginScreen extends StatefulWidget {
  final AuthService? authService;

  const LoginScreen({super.key, this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthService _authService;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _authService = widget.authService ?? AuthService();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    final request = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    final result = await _authService.signInUser(
      email: request.email,
      password: request.password,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        (_) => false,
      );
      return;
    }

    UiHelpers.showSnackBar(
      context,
      result ?? 'Unable to sign in. Please try again.',
      isError: true,
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(),
                const SizedBox(height: 28),
                const FieldLabel('EMAIL ADDRESS'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'demo@slanhpets.com',
                  ).applyFillStyle(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your email address';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                  label: 'PASSWORD',
                  controller: _passwordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter your password';
                    if (v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToForgotPassword,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AuthSubmitButton(
                  label: 'Sign In',
                  isSubmitting: _isSubmitting,
                  onPressed: _signIn,
                ),
                const SizedBox(height: 24),
                const OrDivider(),
                const SizedBox(height: 24),
                SocialLoginButton(
                  label: 'Continue with Google',
                  iconText: 'G',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Google sign-in is coming soon.'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                LoginFooter(onTapSignUp: _navigateToRegister),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
