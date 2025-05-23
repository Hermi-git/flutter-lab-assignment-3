import 'package:equatable/equatable.dart';
import '../../domain/entities/album.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<Album> albums;

  const AlbumsLoaded(this.albums);

  @override
  List<Object> get props => [albums];
}

class AlbumPhotosLoaded extends AlbumState {
  final List<Album> photos;
  final Album mainAlbum;

  const AlbumPhotosLoaded({
    required this.photos,
    required this.mainAlbum,
  });

  @override
  List<Object> get props => [photos, mainAlbum];
}

class AlbumDetailsLoaded extends AlbumState {
  final Album album;

  const AlbumDetailsLoaded(this.album);

  @override
  List<Object> get props => [album];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError(this.message);

  @override
  List<Object> get props => [message];
} 