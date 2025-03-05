import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final bool? autofocus;
  final VoidCallback? onClear;
  final InputDecoration? decoration;
  final Color? backgroundColor;

  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.autofocus = false,
    this.onClear,
    this.decoration,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      onChanged: onChanged,
      style: AppTextStyles.body.copyWith(
        color: isDarkMode ? AppColors.textPrimary : AppColors.textSecondary,
      ),
      decoration: decoration ??
          InputDecoration(
            hintText: hintText ?? 'Search...',
            hintStyle: AppTextStyles.body.copyWith(
              color:
                  isDarkMode ? AppColors.textSecondary : AppColors.textPrimary,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDarkMode ? AppColors.primary : AppColors.secondary,
            ),
            suffixIcon: controller?.text.isNotEmpty ?? false
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color:
                          isDarkMode ? AppColors.primary : AppColors.secondary,
                    ),
                    onPressed: onClear,
                  )
                : null,
            filled: true,
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: const Color.fromARGB(235, 237, 206, 194)
                      // isDarkMode ? AppColors.primary : AppColors.secondary,
                      ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode
                    ? AppColors.primary
                    : const Color.fromARGB(235, 237, 206, 194),
                width: 2,
              ),
            ),
          ),
    );
  }
}
