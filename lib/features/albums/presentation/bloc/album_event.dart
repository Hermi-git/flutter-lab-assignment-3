import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class GetAlbumsEvent extends AlbumEvent {}

class GetAlbumDetailsEvent extends AlbumEvent {
  final int albumId;

  const GetAlbumDetailsEvent(this.albumId);

  @override
  List<Object> get props => [albumId];
} 