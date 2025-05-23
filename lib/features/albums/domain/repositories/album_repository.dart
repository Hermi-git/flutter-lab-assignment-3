import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/album.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>> getAlbums();
  Future<Either<Failure, List<Album>>> getAlbumPhotos(int albumId);
} 