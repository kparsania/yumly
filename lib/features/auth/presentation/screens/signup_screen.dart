import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/Colors.dart';
import '../../../../core/utils/Images.dart';
import '../../../../core/route/screenNames.dart';
import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomTextField.dart';
import '../providers/signup_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Images.logo, height: 70, width: 90),

                  Text('Welcome,', style: TextStyle(fontSize: 28)),
                  Text(
                    'Enter your details to register',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  AppTextField(
                    hintText: 'Enter your Name',
                    prefixIcon: Icons.person,
                    errorText: form.nameError,
                    onChanged: formNotifier.updateName,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hintText: 'Enter Phone no',
                    prefixIcon: Icons.person,
                    errorText: form.numberError,
                    keyboardType: TextInputType.number,
                    onChanged: formNotifier.updateNumber,
                    maxLength: 10,
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    hintText: 'Enter Your Password',
                    errorText: form.passwordError,
                    prefixIcon: Icons.lock_rounded,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    onChanged: formNotifier.updatePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hintText: 'Enter Confirm Password',
                    errorText: form.confirmPasswordError,
                    prefixIcon: Icons.lock_rounded,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    onChanged: formNotifier.updateConfirmPassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  AppButton(
                    label: 'Login',
                    onPressed: () {
                      final isValid = formNotifier.validateForm();
                      if (isValid) {
                        // Proceed with login logic
                        // debugPrint(
                        //   'Login: ${form.number} / ${form.password}',
                        // );
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Already have an account?",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(ScreenNames.SIGN_UP),
                        child: const Text(
                          " Sign In",
                          style: TextStyle(color: Colors.blue),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
