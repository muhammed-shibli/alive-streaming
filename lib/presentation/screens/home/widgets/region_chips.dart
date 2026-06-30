import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../viewmodels/home_viewmodel.dart';

class RegionChips extends StatelessWidget {
  const RegionChips({
    super.key,
    required this.regions,
    required this.activeIndex,
    required this.onChanged,
  });

  final List<RegionFilter> regions;
  final int activeIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final r = regions[i];
          final active = i == activeIndex;
          return _Chip(region: r, active: active, onTap: () => onChanged(i));
        },
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemCount: regions.length,
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.region, required this.active, required this.onTap});

  final RegionFilter region;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inner = Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(region.flag, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            region.label,
            style: AppTextStyles.chip.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (!active) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: inner,
        ),
      );
    }

    // Gradient border for active chip.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(22),
        ),
        child: inner,
      ),
    );
  }
}
