import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/config/theme/app_theme.dart';
import 'package:hello_bazar/feature/home/presentation/page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        title: 'Task 09',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: Home(),
      ),
    );
  }
}
