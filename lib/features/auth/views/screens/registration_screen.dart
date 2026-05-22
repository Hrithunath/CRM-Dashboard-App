import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/features/auth/views/screens/login_screen.dart';
import 'package:pulse/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:pulse/core/widgets/app_text_field.dart';
import 'package:pulse/core/widgets/app_button.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match.';
      });
      return;
    }
    if (!_agreedToTerms) {
      setState(() {
        errorMessage = 'Please agree to the terms and conditions.';
      });
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already in use.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Password should be at least 6 characters.';
        } else {
          errorMessage = e.message ?? 'Registration error.';
        }
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        errorMessage = 'An error occurred. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.dark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r(context)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: 70.r(context),
                        height: 70.r(context),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r(context)),
                        ),
                        child: Icon(Icons.person_add_rounded, size: 40.r(context), color: AppColors.success),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.dark,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Join Pulse CRM and manage your customers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.subtitle,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.r(context)),
                if (errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 20.r(context)),
                        SizedBox(width: 16.r(context)),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 13.r(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (errorMessage != null) const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: emailController,
                  label: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email required';
                    if (!RegExp(r'^.+@.+\..+').hasMatch(value)) return 'Invalid email';
                    return null;
                  },
                ),
                SizedBox(height: 16.r(context)),
                AppTextField(
                  controller: passwordController,
                  label: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password required';
                    if (value.length < 6) return 'Min 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: 16.r(context)),
                AppTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm password';
                    if (value != passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                SizedBox(height: 16.r(context)),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) => setState(() => _agreedToTerms = value ?? false),
                      activeColor: AppColors.success,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.subtitle,
                              ),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.r(context)),
                AppButton(
                  label: _isLoading ? 'Creating account...' : 'Create Account',
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            setState(() => errorMessage = null);
                            _register();
                          }
                        },
                ),
                SizedBox(height: 24.r(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.subtitle,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.r(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
