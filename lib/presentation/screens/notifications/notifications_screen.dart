import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _today = <_Notif>[
    _Notif(
      type: _NotifType.follow,
      title: 'Sofia Chen',
      body: 'started following you',
      time: '2m',
      avatarColor: 0xFFFFB199,
      unread: true,
    ),
    _Notif(
      type: _NotifType.gift,
      title: 'Mia Park',
      body: 'sent you a Rose gift 🌹',
      time: '18m',
      avatarColor: 0xFFA18CD1,
      unread: true,
    ),
    _Notif(
      type: _NotifType.live,
      title: 'Luna Reyes',
      body: 'is going live — Late Night Vibes',
      time: '1h',
      avatarColor: 0xFF89F7FE,
      unread: true,
    ),
  ];

  static const _earlier = <_Notif>[
    _Notif(
      type: _NotifType.comment,
      title: 'Hana Kim',
      body: 'commented on your stream: amazing!',
      time: 'Yesterday',
      avatarColor: 0xFFFAD961,
      unread: false,
    ),
    _Notif(
      type: _NotifType.follow,
      title: 'Ava Lee',
      body: 'started following you',
      time: '2 days ago',
      avatarColor: 0xFFFF9A9E,
      unread: false,
    ),
    _Notif(
      type: _NotifType.gift,
      title: 'Zoe Tan',
      body: 'sent you a Crown gift 👑',
      time: '3 days ago',
      avatarColor: 0xFFB8E940,
      unread: false,
    ),
    _Notif(
      type: _NotifType.live,
      title: 'Nora Ali',
      body: 'invited you to a party room',
      time: 'Last week',
      avatarColor: 0xFF6BC4FF,
      unread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AppBar(),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    _SectionTitle(label: 'Today'),
                    for (final n in _today) _NotifTile(notif: n),
                    const SizedBox(height: 12),
                    _SectionTitle(label: 'Earlier'),
                    for (final n in _earlier) _NotifTile(notif: n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimary, size: 18),
          ),
          Text(
            'Notifications',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: AppColors.textSecondary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

enum _NotifType { follow, gift, live, comment }

class _Notif {
  const _Notif({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.avatarColor,
    required this.unread,
  });
  final _NotifType type;
  final String title;
  final String body;
  final String time;
  final int avatarColor;
  final bool unread;
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({required this.notif});
  final _Notif notif;

  (IconData, Color) _badge() {
    switch (notif.type) {
      case _NotifType.follow:
        return (Icons.person_add_alt_1_rounded, AppColors.primaryGreen);
      case _NotifType.gift:
        return (Icons.card_giftcard_rounded, const Color(0xFFFF5E62));
      case _NotifType.live:
        return (Icons.podcasts_rounded, const Color(0xFFFFB300));
      case _NotifType.comment:
        return (Icons.chat_bubble_rounded, const Color(0xFF6BC4FF));
    }
  }

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _badge();
    return Container(
      color: notif.unread
          ? AppColors.primaryLime.withValues(alpha: 0.08)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Color(notif.avatarColor),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(icon, color: Colors.white, size: 10),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${notif.title} ',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text: notif.body,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                notif.time,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              if (notif.unread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
