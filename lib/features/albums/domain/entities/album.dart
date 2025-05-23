import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String? thumbnailUrl;
  final String? url;

  const Album({
    required this.id,
    required this.userId,
    required this.title,
    this.thumbnailUrl,
    this.url,
  });

  @override
  List<Object?> get props => [id, userId, title, thumbnailUrl, url];
} 