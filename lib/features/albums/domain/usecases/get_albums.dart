import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbums implements UseCase<List<Album>, NoParams> {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  @override
  Future<Either<Failure, List<Album>>> call(NoParams params) async {
    return await repository.getAlbums();
  }
}      