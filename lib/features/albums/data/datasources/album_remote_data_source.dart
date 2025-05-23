import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<List<AlbumModel>> getAlbumPhotos(int albumId);
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  AlbumRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlbumModel>> getAlbums() async {
    final albumsResponse = await client.get(
      Uri.parse('$baseUrl/albums'),
    );

    if (albumsResponse.statusCode == 200) {
      final List<dynamic> albumsJson = json.decode(albumsResponse.body);
      final List<AlbumModel> albums = [];

      for (var albumJson in albumsJson) {
        // Fetch the first photo for each album
        final photosResponse = await client.get(
          Uri.parse('$baseUrl/photos?albumId=${albumJson['id']}&_limit=1'),
        );

        if (photosResponse.statusCode == 200) {
          final List<dynamic> photos = json.decode(photosResponse.body);
          if (photos.isNotEmpty) {
            albumJson['thumbnailUrl'] = photos[0]['thumbnailUrl'];
            albumJson['url'] = photos[0]['url'];
          }
        }

        albums.add(AlbumModel.fromJson(albumJson));
      }
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Future<List<AlbumModel>> getAlbumPhotos(int albumId) async {
    final photosResponse = await client.get(
      Uri.parse('$baseUrl/photos?albumId=$albumId'),
    );

    if (photosResponse.statusCode == 200) {
      final List<dynamic> photos = json.decode(photosResponse.body);
      return photos.map((photo) => AlbumModel.fromJson({
        'id': photo['id'],
        'albumId': photo['albumId'],
        'title': photo['title'],
        'thumbnailUrl': photo['thumbnailUrl'],
        'url': photo['url'],
        'userId': photo['albumId'], // Using albumId as userId since it's required
      })).toList();
    } else {
      throw Exception('Failed to load album photos');
    }
  }
} 