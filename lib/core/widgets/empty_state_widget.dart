import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final Widget? icon;
  const EmptyStateWidget({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          const SizedBox(height: 16),
          Text(message, style: AppTextStyles.subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
