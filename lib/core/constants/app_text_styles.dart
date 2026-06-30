import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Centralised typography. The reference UI uses a rounded, friendly sans-serif
/// (close to Plus Jakarta Sans / Poppins). We use Plus Jakarta Sans via
/// google_fonts which is offline-cacheable.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base(double size, FontWeight weight, {Color? color}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.textPrimary,
        height: 1.25,
      );

  static TextStyle h1 = _base(28, FontWeight.w800);
  static TextStyle h2 = _base(22, FontWeight.w700);
  static TextStyle subtitle =
      _base(14, FontWeight.w500, color: AppColors.textSecondary);

  static TextStyle label =
      _base(14, FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle hint = _base(14, FontWeight.w400, color: AppColors.hintText);
  static TextStyle input = _base(14, FontWeight.w500);

  static TextStyle button = _base(16, FontWeight.w700);
  static TextStyle socialButton = _base(15, FontWeight.w600);

  static TextStyle link = _base(13, FontWeight.w700, color: AppColors.primaryGreenDark);

  static TextStyle tabActive = _base(18, FontWeight.w800);
  static TextStyle tabInactive =
      _base(18, FontWeight.w600, color: AppColors.textSecondary);

  static TextStyle chip = _base(13, FontWeight.w600);
  static TextStyle streamerName = _base(13, FontWeight.w700, color: Colors.white);
  static TextStyle viewers = _base(11, FontWeight.w600, color: Colors.white);
  static TextStyle followChip = _base(11, FontWeight.w700);
  static TextStyle navLabel = _base(11, FontWeight.w600);
}
