import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/album_remote_data_source.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Album>>> getAlbums() async {
    try {
      final albums = await remoteDataSource.getAlbums();
      return Right(albums);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Album>>> getAlbumPhotos(int albumId) async {
    try {
      final photos = await remoteDataSource.getAlbumPhotos(albumId);
      return Right(photos);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
} 