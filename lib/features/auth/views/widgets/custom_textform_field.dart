// import 'package:flutter/material.dart';

// import '../../../../core/utils/constants/color_manager.dart';
// import '../../../../core/utils/constants/values_manager.dart';

// class CustomTextformField extends StatelessWidget {
//   const CustomTextformField({
//     super.key,
//     this.hint,
//     required this.controller,
//     this.onSaved,
//     this.onChanged,
//     required this.isSecure,
//     this.maxLength,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.validator,
//     this.radius,
//   });

//   final String? hint;
//   final TextEditingController controller;
//   final void Function(String?)? onSaved;
//   final void Function(String)? onChanged;
//   final bool ?isSecure;
//   final int? maxLength;
//   final IconButton? prefixIcon;
//   final IconButton? suffixIcon;
//   final String? Function(String?)? validator;
//   final BorderRadius? radius;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppPadding.p24,
//         vertical: AppPadding.p17,
//       ),
//       child: TextFormField(
//         maxLength: maxLength,
//         obscureText: isSecure??false,
//         controller: controller,
//         onSaved: onSaved,
//         // validator: (data) {
//         //   if (controller.text.isEmpty) {
//         //     return "$hint must not be empty!";
//         //   } else {
//         //     return null;
//         //   }
//         // },
//         validator: (data) {
//           String value = controller.text.trim();

//           if (value.isEmpty) return "$hint must not be empty!";
//           if (value.length < 6 ||
//               !value.contains('@') ||
//               !value.endsWith('.com')) {
//             return "Must be at least 6 characters, contain '@', and end with '.com'!";
//           }

//           return null;
//         },

//         onChanged: onChanged,
//         maxLines: maxLength,
//         decoration: InputDecoration(
//           hintText: hint,
//           prefix: prefixIcon,
//           suffixIcon: suffixIcon,
//           border: OutlineInputBorder(
//             borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
//           ),
//           filled: true,
//           fillColor: ColorManager.fillColor,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';


import '../../../../core/utils/constants/color_manager.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hint,
    required this.controller,
    this.onSaved,
    this.onChanged,
    this.isSecure,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.radius,
    this.isEmail = false, this.verticalPadding, this.keyboardType, // default isEmail to false
  });

  final String? hint;
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool? isSecure;
  final int? maxLength;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;
  final BorderRadius? radius;
  final bool isEmail; // new parameter to indicate email fields
final double ?verticalPadding;
final TextInputType? keyboardType;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: verticalPadding?? AppPadding.p17,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: isSecure ?? false,
        controller: controller,
        onSaved: onSaved,
        validator: (data) {
          String value = controller.text.trim();

    
          if (value.isEmpty) return "$hint لا يجب أن يكون فارغًا!";
          if (value.length < 6) return "$hint يجب أن يحتوي على 6 أحرف على الأقل!";

          // Apply email-specific validation only if isEmail is true
          if (isEmail && (!value.contains('@') || !value.endsWith('.com'))) {
            return "  يجب أن يحتوي البريد الإلكتروني على '@' وينتهي بـ '.com'!";
          }

          return null;

         
        },
        onChanged: onChanged,
        maxLines:  isSecure == true ? 1 : maxLength,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
          ),
          filled: true,
          fillColor: ColorManager.fillColor,
          enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.transparent),

            borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
          ),
          focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.transparent),
            borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
          ),
          
        ),
      ),
    );
  }
}

