import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onChanged,
  });

  final int activeIndex;
  final ValueChanged<int> onChanged;

  static const double _height = 72;
  static const double _fabSize = 56;
  static const double _notchRadius = 32;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _height + bottomInset + _fabSize / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Curved background
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: const _NavClipper(notchRadius: _notchRadius),
              child: Container(
                height: _height + bottomInset,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFB8E940),
                      AppColors.primaryGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          // Items row
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            height: _height,
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    icon: Icons.home_outlined,
                    label: AppStrings.home,
                    active: activeIndex == 0,
                    onTap: () => onChanged(0),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.celebration_outlined,
                    label: AppStrings.party,
                    active: activeIndex == 1,
                    onTap: () => onChanged(1),
                  ),
                ),
                const SizedBox(width: 72), // gap reserved for the FAB
                Expanded(
                  child: _NavItem(
                    icon: Icons.send_outlined,
                    label: AppStrings.chats,
                    active: activeIndex == 3,
                    onTap: () => onChanged(3),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.person_outline_rounded,
                    label: AppStrings.profile,
                    active: activeIndex == 4,
                    onTap: () => onChanged(4),
                  ),
                ),
              ],
            ),
          ),
          // Centered Go Live FAB
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onChanged(2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: _fabSize,
                      height: _fabSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.podcasts_rounded,
                          color: AppColors.primaryGreen,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppStrings.goLive,
                      style: AppTextStyles.navLabel.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Colors.white.withValues(alpha: active ? 1 : 0.85);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppTextStyles.navLabel.copyWith(
              color: color,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Flat top edge with a downward semicircular notch in the centre that holds
/// the Go Live FAB.
class _NavClipper extends CustomClipper<Path> {
  const _NavClipper({required this.notchRadius});

  /// Half-width of the notch (matches FAB radius + a small breathing gap).
  final double notchRadius;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final notchStart = cx - notchRadius;
    final notchEnd = cx + notchRadius;

    final p = Path();
    p.moveTo(0, 0);
    p.lineTo(notchStart, 0);
    // Half-circle dipping DOWN into the bar.
    p.arcToPoint(
      Offset(notchEnd, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    p.lineTo(w, 0);
    p.lineTo(w, h);
    p.lineTo(0, h);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant _NavClipper oldClipper) =>
      oldClipper.notchRadius != notchRadius;
}
