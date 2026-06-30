class StreamModel {
  const StreamModel({
    required this.id,
    required this.streamerName,
    required this.thumbnailUrl,
    required this.viewers,
    required this.countryFlag,
    this.isFollowing = false,
  });

  final String id;
  final String streamerName;
  final String thumbnailUrl;
  final int viewers;
  final String countryFlag;
  final bool isFollowing;

  String get viewersLabel {
    if (viewers >= 1000) {
      final k = viewers / 1000;
      return '${k.toStringAsFixed(1)}K';
    }
    return viewers.toString();
  }

  StreamModel copyWith({bool? isFollowing}) => StreamModel(
        id: id,
        streamerName: streamerName,
        thumbnailUrl: thumbnailUrl,
        viewers: viewers,
        countryFlag: countryFlag,
        isFollowing: isFollowing ?? this.isFollowing,
      );

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        id: json['id'] as String,
        streamerName: json['streamer_name'] as String,
        thumbnailUrl: json['thumbnail_url'] as String,
        viewers: json['viewers'] as int,
        countryFlag: json['country_flag'] as String? ?? '',
        isFollowing: json['is_following'] as bool? ?? false,
      );
}
