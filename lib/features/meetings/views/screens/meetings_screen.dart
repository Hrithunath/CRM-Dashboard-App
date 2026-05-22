import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.r(context)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.darkNavy,
                size: 16.r(context),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Meetings',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 20.r(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: _buildEmptyState(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100.r(context),
            height: 100.r(context),
            decoration: BoxDecoration(
              color: AppColors.emptyStateBg,
              borderRadius: BorderRadius.circular(28.r(context)),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              size: 48.r(context),
              color: AppColors.emptyStateIcon,
            ),
          ),
          SizedBox(height: 20.r(context)),
          Text(
            'No Upcoming Meetings',
            style: TextStyle(
              fontSize: 18.r(context),
              fontWeight: FontWeight.w700,
              color: AppColors.darkNavy,
            ),
          ),
          SizedBox(height: 8.r(context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.r(context)),
            child: Text(
              'You don\'t have any scheduled meetings yet. Start by reaching out to your companies.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.r(context),
                color: AppColors.subtitle,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 32.r(context)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.r(context), vertical: 12.r(context)),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r(context)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back to Dashboard',
                style: TextStyle(
                  fontSize: 14.r(context),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
