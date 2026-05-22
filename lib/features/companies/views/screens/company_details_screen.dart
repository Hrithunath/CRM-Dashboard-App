import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';
import 'package:pulse/features/companies/models/company_model.dart';
import 'package:pulse/features/companies/views/widgets/company_card.dart' as company_widgets;
import 'package:pulse/features/companies/views/widgets/contact_info_row.dart';

class CompanyDetailsScreen extends StatelessWidget {
  final Company company;
  const CompanyDetailsScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Company Details',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.r(context)),
        children: [
          _buildHeroCard(context),
          SizedBox(height: 18.r(context)),
          _buildContactInfoCard(context),
          if (company.notes != null && company.notes!.isNotEmpty) ...[
            SizedBox(height: 18.r(context)),
            _buildNotesCard(context),
          ],
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    final colors = AppColors.avatarColorFor(company.name);
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r(context), vertical: 22.r(context)),
        child: Row(
          children: [
            Container(
              width: 54.r(context),
              height: 54.r(context),
              decoration: BoxDecoration(
                color: colors.bg,
                borderRadius: BorderRadius.circular(14.r(context)),
              ),
              child: Center(
                child: Text(
                  company.name.isNotEmpty ? company.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: 22.r(context),
                    fontWeight: FontWeight.w700,
                    color: colors.text,
                  ),
                ),
              ),
            ),
            SizedBox(width: 18.r(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: TextStyle(
                      fontSize: 18.r(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  SizedBox(height: 6.r(context)),
                  company_widgets.StatusBadge(status: company.mockStatus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoCard(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r(context), vertical: 18.r(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CONTACT INFO',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.labelMuted,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 16.r(context)),
            ContactInfoRow(
              icon: Icons.email_rounded,
              iconBg: AppColors.companyAvatar1Bg,
              iconColor: AppColors.companyAvatar1Text,
              label: 'Email',
              value: company.email,
            ),
            SizedBox(height: 10.r(context)),
            ContactInfoRow(
              icon: Icons.location_on_rounded,
              iconBg: AppColors.addressIconBg,
              iconColor: AppColors.companyAvatar4Text,
              label: 'Address',
              value: company.address,
            ),
            SizedBox(height: 10.r(context)),
            ContactInfoRow(
              icon: Icons.phone_rounded,
              iconBg: AppColors.companyAvatar3Bg,
              iconColor: AppColors.companyAvatar3Text,
              label: 'Phone',
              value: company.phone,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r(context), vertical: 18.r(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NOTES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.labelMuted,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 10.r(context)),
            Text(
              company.notes!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.darkNavy,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
