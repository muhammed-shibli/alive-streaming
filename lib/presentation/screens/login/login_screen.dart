import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _googleSignIn() async {
    final vm = context.read<AuthViewModel>();
    final ok = await vm.signInWithGoogle();
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.home,
        (_) => false,
      );
    } else if (vm.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.error!)),
      );
    }
  }

  void _notImplemented() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please continue with Google to sign in')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.primaryGreen,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            // Green wave occupies the bottom ~46% of the screen on every device.
            final waveHeight = h * 0.46;
            return Stack(
              children: [
                // Full-bleed wave background, anchored to bottom.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: waveHeight,
                  child: ClipPath(
                    clipper: _WaveClipper(),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryLime,
                            AppColors.primaryGreen,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Foreground content
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: h -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 16),
                              Center(
                                child: SizedBox(
                                  height: 72,
                                  child: Image.asset(
                                    AppAssets.logo,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.welcomeBack,
                                      style: AppTextStyles.h1
                                          .copyWith(fontSize: 26),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('👋',
                                        style: TextStyle(fontSize: 24)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  AppStrings.welcomeSubtitle,
                                  style: AppTextStyles.subtitle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 28),
                              CustomTextField(
                                label: AppStrings.emailOrPhone,
                                hint: AppStrings.emailHint,
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: AppStrings.password,
                                hint: AppStrings.passwordHint,
                                controller: _passwordCtrl,
                                obscure: true,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(AppRoutes.forgotPassword),
                                  child: Text(
                                    AppStrings.forgotPassword,
                                    style: AppTextStyles.link.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          AppColors.primaryGreenDark,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              PrimaryButton(
                                label: AppStrings.login,
                                onPressed: _notImplemented,
                              ),
                              // Flexible spacer fills any extra vertical room
                              // so the bottom social block is always pinned
                              // toward the bottom of the green wave.
                              const Spacer(),
                              const SizedBox(height: 24),
                              const _OrDivider(),
                              const SizedBox(height: 18),
                              SocialButton(
                                label: AppStrings.continueWithGoogle,
                                icon: const _GoogleIcon(),
                                loading: auth.isLoading,
                                onTap: _googleSignIn,
                              ),
                              const SizedBox(height: 14),
                              SocialButton(
                                label: AppStrings.continueWithFacebook,
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Color(0xFF1877F2),
                                  size: 26,
                                ),
                                onTap: _notImplemented,
                              ),
                              const SizedBox(height: 22),
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text: AppStrings.dontHaveAccount,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppStrings.signUp,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.white70, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            AppStrings.orContinueWith,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: Colors.white70, thickness: 1),
        ),
      ],
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  static const String _pngFallback =
      'https://developers.google.com/identity/images/g-logo.png';
  static const String _svgUrl =
      'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Image.network(
        _pngFallback,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => Image.network(_svgUrl, fit: BoxFit.contain),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    final w = size.width;
    final h = size.height;
    p.moveTo(0, h * 0.16);
    p.cubicTo(
      w * 0.18, h * 0.04,
      w * 0.34, h * 0.16,
      w * 0.5, h * 0.11,
    );
    p.cubicTo(
      w * 0.68, h * 0.06,
      w * 0.82, h * 0.18,
      w, h * 0.09,
    );
    p.lineTo(w, h);
    p.lineTo(0, h);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
