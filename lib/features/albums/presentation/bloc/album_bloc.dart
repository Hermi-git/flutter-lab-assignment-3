import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/album_repository.dart';
import '../../domain/usecases/get_albums.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;
  final AlbumRepository repository;

  AlbumBloc({
    required this.getAlbums,
    required this.repository,
  }) : super(AlbumInitial()) {
    on<GetAlbumsEvent>((event, emit) async {
      emit(AlbumLoading());
      final result = await getAlbums(NoParams());
      result.fold(
        (failure) => emit(const AlbumError('Failed to load albums')),
        (albums) => emit(AlbumsLoaded(albums)),
      );
    });

    on<GetAlbumDetailsEvent>((event, emit) async {
      emit(AlbumLoading());
      final albumsResult = await getAlbums(NoParams());
      
      await albumsResult.fold(
        (failure) async => emit(const AlbumError('Failed to load album details')),
        (albums) async {
          final mainAlbum = albums.firstWhere((a) => a.id == event.albumId);
          final photosResult = await repository.getAlbumPhotos(event.albumId);
          
          photosResult.fold(
            (failure) => emit(const AlbumError('Failed to load album photos')),
            (photos) => emit(AlbumPhotosLoaded(
              photos: photos,
              mainAlbum: mainAlbum,
            )),
          );
        },
      );
    });
  }
} 