import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/features/companies/views/widgets/companies_content.dart';

class CompaniesBody extends StatelessWidget {
  const CompaniesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: CompaniesContent(),
    );
  }
}
