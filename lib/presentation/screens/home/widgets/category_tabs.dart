import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../viewmodels/home_viewmodel.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.active,
    required this.onChanged,
  });

  final HomeTab active;
  final ValueChanged<HomeTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(
        children: [
          _tab(HomeTab.stream, AppStrings.stream),
          const SizedBox(width: 22),
          _tab(HomeTab.hot, AppStrings.hot),
          const SizedBox(width: 22),
          _tab(HomeTab.follow, AppStrings.follow),
        ],
      ),
    );
  }

  Widget _tab(HomeTab tab, String label) {
    final isActive = tab == active;
    return GestureDetector(
      onTap: () => onChanged(tab),
      behavior: HitTestBehavior.opaque,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
          color: isActive ? AppColors.primaryGreenDark : AppColors.textSecondary,
        ),
        child: Text(label),
      ),
    );
  }
}
