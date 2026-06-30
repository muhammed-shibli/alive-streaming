import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand gradient (lime → green) from the logo & login button
  static const Color primaryLime = Color(0xFFD7F23A);
  static const Color primaryGreen = Color(0xFF1FB13A);
  static const Color primaryGreenDark = Color(0xFF0E8A2A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLime, primaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Soft mint used at bottom of login screen / behind tab bar
  static const Color mintWave = Color(0xFFB6E892);

  // Neutrals
  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0F1115);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color hintText = Color(0xFF9CA3AF);
  static const Color fieldFill = Color(0xFFF1F3F5);
  static const Color divider = Color(0xFFE5E7EB);

  // Accents
  static const Color follow = Color(0xFFFFE03A);
  static const Color liveRed = Color(0xFFFF3B30);
  static const Color notificationRed = Color(0xFFFF3B30);
}
