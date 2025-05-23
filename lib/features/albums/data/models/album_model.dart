import '../../domain/entities/album.dart';

class AlbumModel extends Album {
  const AlbumModel({
    required int id,
    required int userId,
    required String title,
    String? thumbnailUrl,
    String? url,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          thumbnailUrl: thumbnailUrl,
          url: url,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
    };
  }
} 