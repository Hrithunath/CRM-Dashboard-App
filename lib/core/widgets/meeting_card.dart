import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class MeetingCard extends StatelessWidget {
  final String companyName;
  final String time;
  final String duration;
  final String type;
  final String? attendee;
  final Color tagColor;
  final Color tagTextColor;

  const MeetingCard({
    Key? key,
    required this.companyName,
    required this.time,
    required this.duration,
    required this.type,
    this.attendee,
    required this.tagColor,
    required this.tagTextColor,
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
        children: [
          // Time Section
          Container(
            width: 70.r(context),
            padding: EdgeInsets.symmetric(vertical: 8.r(context)),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r(context)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                        fontSize: 15.r(context),
                      ),
                ),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.disabled,
                        fontSize: 11.r(context),
                      ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.r(context)),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        companyName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                          fontSize: 16.r(context),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: tagTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.r(context),
                            ),
                      ),
                    ),
                  ],
                ),
                if (attendee != null) ...[
                  SizedBox(height: 6.r(context)),
                  Text(
                    'With: $attendee',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.subtitle,
                            fontSize: 13.r(context),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.r(context)),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.r(context),
            color: AppColors.disabled,
          ),
        ],
      ),
    );
  }
}
