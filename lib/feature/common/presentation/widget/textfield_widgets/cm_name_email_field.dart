import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CmNameEmailField extends StatelessWidget {
  const CmNameEmailField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.label = "",
    this.readOnly = false,
    this.maxLines = 1,
    this.prefixIcon,
  });
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool readOnly;
  final int maxLines;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          textInputAction: TextInputAction.done,
          maxLines: maxLines,
          decoration: InputDecoration(
            //labelText: labelText,
            hintText: hintText,
            prefixIcon: maxLines > 1
                ? Padding(
                    padding: EdgeInsets.only(bottom: (maxLines * 20).h),
                    child: prefixIcon,
                  )
                : prefixIcon,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          validator: (value) {
            // // validation if it's city
            // if (label.toLowerCase().contains('city')) {
            //   final haveNumber = _containsNumber(value!.trim());
            //   final haveSpecialChar = _containsSpecialChar(value.trim());
            //   if (value.trim().isEmpty) {
            //     return 'Please give your City.';
            //   } else if (haveNumber || haveSpecialChar) {
            //     return 'Cities can\'t have number or special character';
            //   } else {
            //     return null;
            //   }
            // }
            // // validation for email address
            // else

            if (label.toLowerCase().contains('email')) {
              final haveDotCom = value!.trim().contains(".com");
              final haveDotOrg = value.trim().contains(".org");
              final haveSpace = value.trim().contains("..");
              final haveAtTheRate = value.trim().contains("@");
              if (value.trim().isEmpty) {
                return 'Please give your email address.';
              } else if ((!haveDotCom && !haveDotOrg) ||
                  !haveAtTheRate ||
                  haveSpace) {
                return 'Please give a valid email address';
              } else {
                return null;
              }
            }
            // validation for name or address
            else {
              if (value!.trim().isEmpty) {
                return 'Please give your $label';
              } else {
                return null;
              }
            }
          },
        ),
      ],
    );
  }

  // bool _containsNumber(String str) {
  //   RegExp numberRegex = RegExp(r'[0-9]');
  //   return numberRegex.hasMatch(str);
  // }

  // bool _containsSpecialChar(String str) {
  //   RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  //   return specialCharacterRegex.hasMatch(str);
  // }
}
