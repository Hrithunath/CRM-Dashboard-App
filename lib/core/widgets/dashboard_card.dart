
import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_text_styles.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color cardColor;
  final Color iconBgColor;
  final Color contentColor;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.cardColor,
    required this.iconBgColor,
    required this.contentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16.r(context)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: contentColor.withOpacity(0.1),
        highlightColor: contentColor.withOpacity(0.05),
        child: Stack(
          children: [
            // Decorative blob in top-right corner
            Positioned(
              top: -18,
              right: -18,
              child: Container(
                width: 72.r(context),
                height: 72.r(context),
                decoration: BoxDecoration(
                  color: iconBgColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.r(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon box
                  Container(
                    width: 36.r(context),
                    height: 36.r(context),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12.r(context)),
                    ),
                    child: Icon(icon, color: contentColor, size: 18.r(context)),
                  ),
                  SizedBox(height: 12.r(context)),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: AppTextStyles.headline2.copyWith(
                          color: contentColor,
                          height: 1,
                          fontSize: 26.r(context),
                        ),
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.r(context)),
                  // Title — no ellipsis, let it wrap naturally
                  Text(
                    title,
                    style: AppTextStyles.subtitle.copyWith(
                      color: contentColor.withOpacity(0.75),
                      fontSize: 12.r(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
