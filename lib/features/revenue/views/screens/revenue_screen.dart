import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/features/auth/views/screens/login_screen.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';
import 'package:pulse/core/widgets/logout_confirmation_dialog.dart';

class RevenueScreen extends StatelessWidget {
  final double totalRevenue;
  final int totalCompanies;

  const RevenueScreen({
    super.key,
    required this.totalRevenue,
    required this.totalCompanies,
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
          'Revenue',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 20.r(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppColors.darkNavy,
                  size: 18,
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
      body: totalRevenue == 0 ? _buildEmptyState(context) : _buildRevenueData(context),
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
              Icons.currency_rupee_rounded,
              size: 48.r(context),
              color: AppColors.emptyStateIcon,
            ),
          ),
          SizedBox(height: 20.r(context)),
          Text(
            'No Revenue Yet',
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
              'Revenue will be tracked as you engage with companies.',
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

  Widget _buildRevenueData(BuildContext context) {
    final avgRevenue = totalCompanies > 0 ? totalRevenue / totalCompanies : 0.0;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.r(context), vertical: 16.r(context)),
      children: [
        Container(
          padding: EdgeInsets.all(20.r(context)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r(context)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Revenue',
                style: TextStyle(
                  fontSize: 14.r(context),
                  fontWeight: FontWeight.w600,
                  color: AppColors.subtitle,
                ),
              ),
              SizedBox(height: 12.r(context)),
              Text(
                '₹${totalRevenue.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 36.r(context),
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 4.r(context)),
              Text(
                'From ${totalCompanies} companies',
                style: TextStyle(
                  fontSize: 12.r(context),
                  color: AppColors.subtitle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.r(context)),
        Container(
          padding: EdgeInsets.all(16.r(context)),
          decoration: BoxDecoration(
            color: AppColors.dashboardGreenCard,
            borderRadius: BorderRadius.circular(12.r(context)),
          ),
          child: Row(
            children: [
              Container(
                width: 48.r(context),
                height: 48.r(context),
                decoration: BoxDecoration(
                  color: AppColors.dashboardGreenIcon,
                  borderRadius: BorderRadius.circular(10.r(context)),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.dashboardGreenContent,
                  size: 24.r(context),
                ),
              ),
              SizedBox(width: 12.r(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Revenue per Company',
                      style: TextStyle(
                        fontSize: 13.r(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.dashboardGreenContent,
                      ),
                    ),
                    SizedBox(height: 4.r(context)),
                    Text(
                      '₹${avgRevenue.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16.r(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.dashboardGreenContent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.r(context)),
        Text(
          'Company Breakdown',
          style: TextStyle(
            fontSize: 16.r(context),
            fontWeight: FontWeight.w700,
            color: AppColors.darkNavy,
          ),
        ),
        SizedBox(height: 12.r(context)),
        ...List.generate(
          totalCompanies.clamp(0, 5),
          (index) {
            final companyNames = [
              'Acme Corp',
              'TechStart Inc',
              'Global Solutions',
              'Innovation Labs',
              'Digital Ventures',
            ];
            final companyName = companyNames[index % companyNames.length];
            final companyRevenue = (totalRevenue / totalCompanies).toStringAsFixed(0);

            return Padding(
              padding: EdgeInsets.only(bottom: 10.r(context)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.r(context), vertical: 12.r(context)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companyName,
                            style: TextStyle(
                              fontSize: 14.r(context),
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkNavy,
                            ),
                          ),
                          SizedBox(height: 2.r(context)),
                          Text(
                            'Active',
                            style: TextStyle(
                              fontSize: 12.r(context),
                              color: AppColors.subtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹$companyRevenue',
                      style: TextStyle(
                        fontSize: 14.r(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (totalCompanies > 5)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Center(
              child: Text(
                '+${totalCompanies - 5} more companies',
                style: TextStyle(
                  fontSize: 13.r(context),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
