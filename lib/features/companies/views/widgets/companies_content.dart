import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse/core/widgets/search_bar_widget.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/features/companies/controllers/companies_controller.dart';
import 'package:pulse/features/companies/views/widgets/companies_list.dart';

class CompaniesContent extends StatelessWidget {
  const CompaniesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CompaniesController>();

    return Column(
      children: [
        SearchBarWidget(
          hintText: 'Search companies...',
          onChanged: (value) => controller.search(value),
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: CompaniesList(controller: controller),
        ),
      ],
    );
  }
}
