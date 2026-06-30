import 'package:flutter/material.dart';

import '../../presentation/screens/forgot_password/forgot_password_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/notifications/notifications_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String forgotPassword = '/forgot-password';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
        home: (_) => const HomeScreen(),
        notifications: (_) => const NotificationsScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
      };
}
