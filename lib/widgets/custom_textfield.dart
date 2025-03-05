// import 'package:flutter/material.dart';

// import '../theme/theme.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final String? labelText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final void Function(String)? onChanged;
//   final String? Function(String?)? validator;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final int? maxLines;
//   final int? minLines;
//   final bool enabled;
//   final InputDecoration? decoration;

//   const CustomTextField({
//     super.key,
//     this.controller,
//     this.hintText,
//     this.labelText,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.onChanged,
//     this.validator,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.maxLines = 1,
//     this.minLines,
//     this.enabled = true,
//     this.decoration,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       onChanged: onChanged,
//       validator: validator,
//       maxLines: maxLines,
//       minLines: minLines,
//       enabled: enabled,
//       style: AppTextStyles.body,
//       decoration: decoration ??
//           InputDecoration(
//             hintText: hintText,
//             labelText: labelText,
//             hintStyle:
//                 AppTextStyles.body.copyWith(color: AppColors.textSecondary),
//             labelStyle: AppTextStyles.body.copyWith(color: AppColors.primary),
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: AppColors.primary),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: AppColors.primary, width: 2),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.red),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.red, width: 2),
//             ),
//             errorStyle: AppTextStyles.caption.copyWith(color: Colors.red),
//           ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      style: AppTextStyles.body.copyWith(
        color: isDarkMode ? AppColors.textPrimary : AppColors.textSecondary,
      ),
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            labelText: labelText,
            hintStyle: AppTextStyles.body.copyWith(
              color:
                  isDarkMode ? AppColors.textSecondary : AppColors.textPrimary,
            ),
            labelStyle: AppTextStyles.body.copyWith(
              color: isDarkMode ? AppColors.primary : AppColors.secondary,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.primary : AppColors.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.primary : AppColors.secondary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            errorStyle: AppTextStyles.caption.copyWith(color: Colors.red),
          ),
    );
  }
}
