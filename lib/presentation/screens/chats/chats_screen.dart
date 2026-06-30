import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  static const List<_Chat> _chats = [
    _Chat('Sofia Chen', 'See you on stream tonight! 🎥', '2m', 2, true, 0xFFFFB199),
    _Chat('Mia Park', 'Thanks for the gift 💚', '12m', 0, true, 0xFFA18CD1),
    _Chat('Luna Reyes', 'Are you joining the party?', '1h', 1, false, 0xFF89F7FE),
    _Chat('Hana Kim', 'Sent a voice message', '3h', 0, true, 0xFFFAD961),
    _Chat('Ava Lee', 'Loved your last live ❤️', 'Yesterday', 0, false, 0xFFFF9A9E),
    _Chat('Zoe Tan', 'Let\'s collab next week', 'Mon', 0, false, 0xFFB8E940),
    _Chat('Nora Ali', 'Typing...', 'Sun', 0, true, 0xFF6BC4FF),
    _Chat('Iris Cruz', 'Followed you back 🎉', 'Sat', 0, false, 0xFFFFC2A1),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(),
        const SizedBox(height: 10),
        _SearchField(),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 120),
            itemCount: _chats.length,
            separatorBuilder: (_, _) => Padding(
              padding: const EdgeInsets.only(left: 86),
              child: Divider(
                color: AppColors.divider.withValues(alpha: 0.6),
                height: 1,
              ),
            ),
            itemBuilder: (_, i) => _ChatRow(chat: _chats[i]),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Text(
            'Chats',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded,
                size: 18, color: AppColors.hintText),
            const SizedBox(width: 8),
            Text(
              'Search messages',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.hintText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chat {
  const _Chat(this.name, this.lastMessage, this.time, this.unread, this.online,
      this.avatarColor);
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final bool online;
  final int avatarColor;
}

class _ChatRow extends StatelessWidget {
  const _ChatRow({required this.chat});
  final _Chat chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Color(chat.avatarColor),
                    shape: BoxShape.circle,
                  ),
                ),
                if (chat.online)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: chat.unread > 0
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: chat.unread > 0
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: chat.unread > 0
                        ? AppColors.primaryGreenDark
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                if (chat.unread > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    constraints:
                        const BoxConstraints(minWidth: 18, minHeight: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${chat.unread}',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
