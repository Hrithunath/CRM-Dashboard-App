import 'package:flutter/material.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  const SkeletonGrid({super.key, this.itemCount = 4, this.crossAxisCount = 2});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(itemCount, (index) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        )),
      ),
    );
  }
}
