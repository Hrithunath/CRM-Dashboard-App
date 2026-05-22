import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/theme/app_text_styles.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final Color? color;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? 48.r(context);

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          disabledBackgroundColor: AppColors.disabled,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r(context)),
          ),
        ),
        onPressed: enabled && !loading ? onPressed : null,
        child: loading
            ? Builder(
                builder: (context) => SizedBox(
                  width: 24.r(context),
                  height: 24.r(context),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            : Text(label, style: AppTextStyles.body.copyWith(color: Colors.white)),
      ),
    );
  }
}
