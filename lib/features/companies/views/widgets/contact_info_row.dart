import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  const ContactInfoRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.r(context),
          height: 32.r(context),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10.r(context)),
          ),
          child: Icon(icon, color: iconColor, size: 18.r(context)),
        ),
        SizedBox(width: 14.r(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.r(context),
                  color: AppColors.labelMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.r(context)),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.r(context),
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
