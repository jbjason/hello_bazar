import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class HomeNavbarCartButton extends StatelessWidget {
  const HomeNavbarCartButton({
    super.key,
    required this.itemWidth,
    required this.bottomHeight,
  });
  final double itemWidth;
  final double bottomHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          width: itemWidth * .8,
          height: itemWidth * .8,
          bottom: bottomHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColor.primary,
            ),
            child: Icon(Icons.shopping_cart, color: MyColor.white, size: 24.w),
          ),
        ),
      ],
    );
  }
}
