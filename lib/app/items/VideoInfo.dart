class VideoInfo {
  final String title;
  final String uploader;
  final int duration;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final double averageRating;
  final String uploadDate;
  final String description;
  final String thumbnail;
  final List formats;

  VideoInfo({
    required this.title,
    required this.uploader,
    required this.duration,
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.averageRating,
    required this.uploadDate,
    required this.description,
    required this.thumbnail,
    required this.formats,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      title: json['title'] ?? 'N/A',
      uploader: json['uploader'] ?? 'N/A',
      duration: json['duration'] is int ? json['duration'] : int.tryParse(json['duration']?.toString() ?? '0') ?? 0,
      viewCount: json['view_count'] is int ? json['view_count'] : int.tryParse(json['view_count']?.toString() ?? '0') ?? 0,
      likeCount: json['like_count'] is int ? json['like_count'] : int.tryParse(json['like_count']?.toString() ?? '0') ?? 0,
      dislikeCount: json['dislike_count'] is int ? json['dislike_count'] : int.tryParse(json['dislike_count']?.toString() ?? '0') ?? 0,
      averageRating: json['average_rating'] is double ? json['average_rating'] : double.tryParse(json['average_rating']?.toString() ?? '0.0') ?? 0.0,
      uploadDate: json['upload_date'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
      thumbnail: json['thumbnail'] ?? 'N/A',
      formats: json['formats'] ?? [],
    );
  }
}
