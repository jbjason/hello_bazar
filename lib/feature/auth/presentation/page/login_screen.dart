import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/config/theme/app_theme.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isOtpSent = false;
  bool _isLoading = false;
  int _resendTimer = 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendTimer = 60);
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
        return true;
      }
      return false;
    });
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
      _isOtpSent = true;
    });
    _startResendTimer();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent to ${_phoneController.text}'),
          backgroundColor: MyColor.success,
        ),
      );
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: MyColor.error,
        ),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    // Navigate to home or dashboard
    if (mounted) {
      // Replace with your home page navigation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: MyColor.success,
        ),
      );
    }
  }

  void _resendOtp() {
    if (_resendTimer > 0) return;
    _sendOtp();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24.w : 48.w,
              vertical: 24.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo or App Icon
                  Icon(
                    Icons.store_rounded,
                    size: isMobile ? 80.w : 100.w,
                    color: MyColor.primary,
                  ),
                  SizedBox(height: 16.h),
                  
                  // Title
                  Text(
                    'Loyalty Plus POS',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  
                  Text(
                    'Track daily sales & customer loyalty',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: MyColor.gray500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48.h),
                  
                  // Phone Number Input
                  TextFormField(
                    controller: _phoneController,
                    enabled: !_isOtpSent && !_isLoading,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '01XXXXXXXXX',
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        size: isMobile ? 20.w : 24.w,
                      ),
                      suffixIcon: _isOtpSent
                          ? IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                setState(() {
                                  _isOtpSent = false;
                                  _otpController.clear();
                                  _resendTimer = 0;
                                });
                              },
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      if (value.length != 11) {
                        return 'Phone number must be 11 digits';
                      }
                      if (!value.startsWith('01')) {
                        return 'Phone number must start with 01';
                      }
                      return null;
                    },
                  ),
                  
                  if (_isOtpSent) ...[
                    SizedBox(height: 24.h),
                    
                    // OTP Input
                    TextFormField(
                      controller: _otpController,
                      enabled: !_isLoading,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        hintText: '000000',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          size: isMobile ? 20.w : 24.w,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 24.sp : 28.sp,
                        letterSpacing: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    
                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive OTP? ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: _resendTimer > 0 ? null : _resendOtp,
                          child: Text(
                            _resendTimer > 0
                                ? 'Resend in ${_resendTimer}s'
                                : 'Resend OTP',
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  SizedBox(height: 32.h),
                  
                  // Action Button
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : (_isOtpSent ? _verifyOtp : _sendOtp),
                    child: _isLoading
                        ? SizedBox(
                            height: isMobile ? 20.h : 24.h,
                            width: isMobile ? 20.w : 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                MyColor.onPrimary,
                              ),
                            ),
                          )
                        : Text(_isOtpSent ? 'Verify & Login' : 'Send OTP'),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Terms & Privacy
                  Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MyColor.gray400,
                    ),
                    textAlign: TextAlign.center,
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

// ==================== LOGOUT CONFIRMATION DIALOG ====================
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: MyColor.gray500,
            ),
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
                    side: BorderSide(
                      color: MyColor.outlineVariant,
                      width: 1.w,
                    ),
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
                  onPressed: () => Navigator.pop(context, true),
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

// ==================== LOGOUT PAGE (Alternative Full Screen) ====================
class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: MyColor.gray500,
                ),
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
                      builder: (context) => const LoginPage(),
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

// ==================== USAGE EXAMPLE ====================
// To show logout dialog from anywhere:
// final shouldLogout = await LogoutDialog.show(context);
// if (shouldLogout == true) {
//   // Clear user session/token
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => const LoginPage()),
//   );
// }

// Or use the full screen logout page:
// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(builder: (context) => const LogoutPage()),
// );