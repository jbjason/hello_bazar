import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/config/theme/app_theme.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/auth/presentation/screen/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 24.w : 48.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Icon(
                Icons.waving_hand_rounded,
                size: isMobile ? 80.w : 100.w,
                color: MyColor.primary,
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                'See You Soon!',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),

              // Message
              Text(
                'You have been successfully logged out. Come back anytime to manage your store.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: MyColor.gray500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),

              // Login Again Button
              ElevatedButton(
                onPressed: () {
                  // Navigate back to login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Login Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
