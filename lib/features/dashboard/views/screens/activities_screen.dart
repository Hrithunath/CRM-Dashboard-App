import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/features/auth/views/screens/login_screen.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';
import 'package:pulse/core/widgets/logout_confirmation_dialog.dart';

class ActivitiesScreen extends StatelessWidget {
  final int totalActivities;
  final List<String>? activityList;

  const ActivitiesScreen({
    super.key,
    required this.totalActivities,
    this.activityList,
  });

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
          'Activities',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 20.r(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.r(context)),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppColors.darkNavy,
                  size: 18.r(context),
                ),
                onPressed: () async {
                  final shouldLogout = await showLogoutConfirmationDialog(context);
                  if (!shouldLogout || !context.mounted) {
                    return;
                  }
                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: totalActivities == 0 ? _buildEmptyState(context) : _buildActivityList(context),
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
              Icons.trending_up_rounded,
              size: 48.r(context),
              color: AppColors.emptyStateIcon,
            ),
          ),
          SizedBox(height: 20.r(context)),
          Text(
            'No Activities Yet',
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
              'Activities will appear here when companies are engaged.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.r(context),
                color: AppColors.subtitle,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.r(context), vertical: 16.r(context)),
      itemCount: totalActivities,
      separatorBuilder: (_, __) => SizedBox(height: 12.r(context)),
      itemBuilder: (context, index) {
        final activityNumber = index + 1;
        final activities = [
          'Meeting scheduled with client',
          'Email sent to prospect',
          'Call completed with sales team',
          'Quote proposal sent',
          'Contract signed',
          'Payment received',
          'Follow-up reminder created',
          'Document uploaded',
          'Status updated to Active',
          'Note added to company profile',
        ];
        final activity = activities[activityNumber % activities.length];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.r(context), vertical: 14.r(context)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r(context)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44.r(context),
                height: 44.r(context),
                decoration: BoxDecoration(
                  color: AppColors.dashboardAmberCard,
                  borderRadius: BorderRadius.circular(10.r(context)),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.dashboardAmberContent,
                  size: 24.r(context),
                ),
              ),
              SizedBox(width: 12.r(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.r(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    SizedBox(height: 4.r(context)),
                    Text(
                      'Activity #$activityNumber',
                      style: TextStyle(
                        fontSize: 12.r(context),
                        color: AppColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
