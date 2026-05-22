import 'package:flutter/material.dart';
import 'package:pulse/core/widgets/skeleton_list.dart';
import 'package:pulse/core/widgets/error_view.dart';
import 'package:pulse/core/widgets/empty_state_widget.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/features/companies/controllers/companies_controller.dart';
import 'package:pulse/features/companies/views/widgets/company_card.dart';

class CompaniesList extends StatelessWidget {
  final CompaniesController controller;
  const CompaniesList({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isFetching && controller.companies.isEmpty) {
      return const SkeletonList();
    }

    if (controller.isEmpty) {
      return const EmptyStateWidget(
        message: 'No companies found.',
      );
    }

    if (controller.errorMessage != null && controller.companies.isEmpty) {
      return ErrorView(
        message: controller.errorMessage!,
        onRetry: () => controller.fetchCompanies(refresh: true),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => controller.refresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels >= notification.metrics.maxScrollExtent - 100 &&
              controller.hasMore) {
            controller.loadMore();
          }
          return false;
        },
        child: ListView.separated(
          itemCount: controller.hasMore ? controller.companies.length + 1 : controller.companies.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            if (index >= controller.companies.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final company = controller.companies[index];

            return CompanyCard(company: company);
          },
        ),
      ),
    );
  }
}
