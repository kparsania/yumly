// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/login_provider.dart';
//
// class LoginScreen extends ConsumerWidget {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(authControllerProvider);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             if (state.isLoggedIn)
//               const Text("🎉 Logged In Successfully!", style: TextStyle(fontSize: 18)),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 12),
//             if (state.error != null)
//               Text(state.error!, style: const TextStyle(color: Colors.red)),
//             ElevatedButton(
//               onPressed: state.isLoading
//                   ? null
//                   : () {
//                 ref.read(authControllerProvider.notifier).products(
//                   emailController.text,
//                   passwordController.text,
//                 );
//               },
//               child: state.isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import '../../../../core/route/screenNames.dart';
import '../../../../core/utils/Colors.dart';
import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomTextField.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(loginFormProvider);
    final formNotifier = ref.read(loginFormProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w,
                    child: CustomImage(
                      source: Images.logo,
                      height: 70.h,
                      width: 90.w,
                    ),
                  ),

                  CustomText('Welcome Back,', fontSize: 28),
                  CustomText(
                    'Enter your details and products',
                    color: AppColors.textSecondary,
                  ),

                  SizedBox(height: 24.h),

                  AppTextField(
                    hintText: 'Enter Phone no',
                    prefixIcon: Icons.person,
                    errorText: form.numberError,
                    keyboardType: TextInputType.number,
                    onChanged: formNotifier.updateNumber,
                    maxLength: 10,
                  ),

                  SizedBox(height: 16.h),

                  AppTextField(
                    hintText: 'Enter Password',
                    errorText: form.passwordError,
                    prefixIcon: Icons.lock_rounded,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    onChanged: formNotifier.updatePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Login Button
                  AppButton(
                    label: 'Login',
                    onPressed: () {
                      final isValid = formNotifier.validateForm();
                        context.go(ScreenNames.BOTTOM_TABS);
                      if (isValid) {
                        debugPrint('Login: ${form.number} / ${form.password}');
                      }
                    },
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CustomText(
                          "Don't have an account?",
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(ScreenNames.SIGN_UP),
                        child: const CustomText(" Sign up", color: Colors.blue),
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
