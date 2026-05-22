import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const ActivityCard({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r(context)),
      margin: EdgeInsets.only(bottom: 16.r(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r(context)),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 50.r(context),
            height: 50.r(context),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10.r(context)),
            ),
            child: Icon(icon, color: iconColor, size: 24.r(context)),
          ),
          SizedBox(width: 16.r(context)),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                        fontSize: 16.r(context),
                      ),
                ),
                SizedBox(height: 4.r(context)),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.subtitle,
                        fontSize: 13.r(context),
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.r(context)),
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.disabled,
                        fontSize: 12.r(context),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
