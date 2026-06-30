import '../models/stream_model.dart';

/// Stub repository — returns mock data so the UI is fully functional offline.
/// Wire to [ApiClient] (lib/core/api/api_client.dart) when the real endpoint
/// is available; the rest of the app is API-shape ready.
class StreamRepository {
  // 12 distinct portrait images so the grid never repeats on the first scroll.
  static const List<String> _thumbnails = [
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1502323777036-f29e3972d82f?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1542740348-39501cd6e2b4?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1546961342-1d29ad5b3a3a?w=600&q=80&auto=format&fit=crop',
  ];

  Future<List<StreamModel>> fetchStreams({String region = 'global'}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(_thumbnails.length, (i) {
      return StreamModel(
        id: 'stream_$i',
        streamerName: 'Sofia Chen',
        thumbnailUrl: _thumbnails[i],
        viewers: 8200,
        countryFlag: '🇵🇭',
      );
    });
  }
}
