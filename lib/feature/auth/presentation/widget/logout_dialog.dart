import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/config/theme/app_theme.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/auth/presentation/screen/logout_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      contentPadding: EdgeInsets.all(isMobile ? 24.w : 32.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(isMobile ? 16.w : 20.w),
            decoration: BoxDecoration(
              color: MyColor.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout_rounded,
              size: isMobile ? 40.w : 48.w,
              color: MyColor.error,
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Text(
            'Logout',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          // Message
          Text(
            'Are you sure you want to logout? You will need to enter your phone number and OTP again to login.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: MyColor.gray500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: MyColor.outlineVariant, width: 1.w),
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 12.h : 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: isMobile ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogoutScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.error,
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 12.h : 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: isMobile ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}