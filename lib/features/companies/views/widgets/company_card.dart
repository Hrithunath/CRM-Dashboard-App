import 'package:flutter/material.dart';
import 'package:pulse/features/companies/models/company_model.dart';
import 'package:pulse/core/theme/app_colors.dart';
import 'package:pulse/core/extensions/responsive_size_extensions.dart';
// app_spacing not used here
import 'package:pulse/features/companies/views/screens/company_details_screen.dart';

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({required this.company, super.key});

  @override
  Widget build(BuildContext context) {
    final avatarPalette = AppColors.avatarColorFor(company.name);
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r(context), vertical: 12.r(context)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CompanyDetailsScreen(company: company),
                  ),
                ),
                child: Container(
                  width: 50.r(context),
                  height: 50.r(context),
                  decoration: BoxDecoration(
                    color: avatarPalette.bg,
                    borderRadius: BorderRadius.circular(12.r(context)),
                  ),
                  child: Center(
                    child: Text(
                      company.name.isNotEmpty ? company.name[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 18.r(context),
                        fontWeight: FontWeight.w700,
                        color: avatarPalette.text,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.r(context)),

              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompanyDetailsScreen(company: company),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        company.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.r(context),
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),

                      SizedBox(height: 3.r(context)),

                      Text(
                        company.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.r(context),
                          color: AppColors.subtitle,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 6.r(context)),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 8.r(context)),

              StatusBadge(status: company.mockStatus),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final statusPalette = AppColors.statusColorFor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r(context), vertical: 5.r(context)),
      decoration: BoxDecoration(
        color: statusPalette.bg,
        borderRadius: BorderRadius.circular(16.r(context)),
      ),
      child: Text(
        status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase(),
        style: TextStyle(
          fontSize: 11.r(context),
          fontWeight: FontWeight.w600,
          color: statusPalette.text,
        ),
      ),
    );
  }
}
