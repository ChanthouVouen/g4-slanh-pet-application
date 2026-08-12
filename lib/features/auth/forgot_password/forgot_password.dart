import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/auth_paw_badge.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/widgets/customer_text_field.dart';
import 'package:slanh_pet_application/core/constants/forgot_password/forgot_password_string.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _emailSent = false;

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _emailSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ForgotPasswordString.success,
            style: TextStyle(color: AppColors.success),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ForgotPasswordString.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ForgotPasswordString.appbarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthPawBadge(),

                const SizedBox(height: 32),

                CustomTextField(
                  label: ForgotPasswordString.label,
                  hintText: ForgotPasswordString.hintText,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ForgotPasswordString.emptyEmail;
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return ForgotPasswordString.validEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                AuthSubmitButton(
                  label: _emailSent
                      ? ForgotPasswordString.buttonResend
                      : ForgotPasswordString.buttonSend,
                  isSubmitting: _isSubmitting,
                  onPressed: _sendEmail,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
