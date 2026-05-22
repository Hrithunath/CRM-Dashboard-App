import 'package:flutter/material.dart';
import 'package:pulse/core/widgets/dashboard_card.dart';
import 'package:pulse/core/widgets/activity_card.dart';
import 'package:pulse/core/widgets/meeting_card.dart';
import 'package:pulse/core/widgets/section_header.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';
import 'package:pulse/features/companies/views/screens/companies_screen.dart';
import 'package:pulse/features/revenue/views/screens/revenue_screen.dart';
import 'package:pulse/features/dashboard/views/screens/activities_screen.dart';
import 'package:pulse/features/meetings/views/screens/meetings_screen.dart';
import 'package:pulse/features/dashboard/services/dashboard_repository.dart';

class DashboardContent extends StatelessWidget {
  final DashboardData data;
  final List<Map<String, dynamic>> sampleActivities;
  final List<Map<String, dynamic>> sampleMeetings;
  const DashboardContent({required this.data, required this.sampleActivities, required this.sampleMeetings, super.key});

  Widget _buildCards(BuildContext context) {
    return SizedBox(
      height: 360.r(context),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16.r(context),
        crossAxisSpacing: 16.r(context),
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.05,
        children: [
          DashboardCard(
            title: 'Companies',
            value: data.totalCompanies.toString(),
            icon: Icons.business_rounded,
            cardColor: AppColors.dashboardBlueCard,
            iconBgColor: AppColors.dashboardBlueIcon,
            contentColor: AppColors.dashboardBlueContent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CompaniesScreen())),
          ),
          DashboardCard(
            title: 'Revenue',
            value: '₹${data.totalRevenue.toStringAsFixed(0)}',
            icon: Icons.currency_rupee_rounded,
            cardColor: AppColors.dashboardGreenCard,
            iconBgColor: AppColors.dashboardGreenIcon,
            contentColor: AppColors.dashboardGreenContent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RevenueScreen(totalRevenue: data.totalRevenue, totalCompanies: data.totalCompanies))),
          ),
          DashboardCard(
            title: 'Activities',
            value: data.totalActivities.toString(),
            icon: Icons.trending_up_rounded,
            cardColor: AppColors.dashboardAmberCard,
            iconBgColor: AppColors.dashboardAmberIcon,
            contentColor: AppColors.dashboardAmberContent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ActivitiesScreen(totalActivities: data.totalActivities))),
          ),
          DashboardCard(
            title: 'Meetings',
            value: data.totalMeetings.toString(),
            icon: Icons.calendar_month_rounded,
            cardColor: AppColors.dashboardPurpleCard,
            iconBgColor: AppColors.dashboardPurpleIcon,
            contentColor: AppColors.dashboardPurpleContent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MeetingsScreen())),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Overview'),
          SizedBox(height: 24.r(context)),
          _buildCards(context),
          SizedBox(height: 32.r(context)),
          const SectionHeader(title: 'Recent Activities'),
          SizedBox(height: 16.r(context)),
          ...sampleActivities.map((activity) => ActivityCard(
                title: activity['title'],
                description: activity['description'],
                time: activity['time'],
                icon: activity['icon'],
                iconBgColor: activity['iconBgColor'],
                iconColor: activity['iconColor'],
              )),
          SizedBox(height: 32.r(context)),
          const SectionHeader(title: 'Upcoming Meetings'),
          SizedBox(height: 16.r(context)),
          ...sampleMeetings.map((meeting) => MeetingCard(
                companyName: meeting['company'],
                time: meeting['time'],
                duration: meeting['duration'],
                type: meeting['type'],
                attendee: meeting['attendee'],
                tagColor: meeting['tagColor'],
                tagTextColor: meeting['tagTextColor'],
              )),
        ],
      ),
    );
  }
}
