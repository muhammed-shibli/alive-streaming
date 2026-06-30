import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../data/models/stream_model.dart';

class StreamCard extends StatelessWidget {
  const StreamCard({
    super.key,
    required this.stream,
    required this.onFollowTap,
    required this.onTap,
  });

  final StreamModel stream;
  final VoidCallback onFollowTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: const Color(0xFFE5E7EB)),
            Image.network(
              stream.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  Container(color: const Color(0xFFE5E7EB)),
              loadingBuilder: (c, w, p) =>
                  p == null ? w : Container(color: const Color(0xFFE5E7EB)),
            ),
            // subtle bottom darkening for text legibility
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // viewers pill
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.visibility,
                        color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(stream.viewersLabel, style: AppTextStyles.viewers),
                  ],
                ),
              ),
            ),
            // streamer info bottom
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(color: Colors.white, width: 1.2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          stream.streamerName,
                          style: AppTextStyles.streamerName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          stream.countryFlag,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onFollowTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: stream.isFollowing
                            ? Colors.white
                            : AppColors.follow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        stream.isFollowing ? 'Following' : AppStrings.followBtn,
                        style: AppTextStyles.followChip.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
