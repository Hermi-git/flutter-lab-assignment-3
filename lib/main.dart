import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'features/albums/data/datasources/album_remote_data_source.dart';
import 'features/albums/data/repositories/album_repository_impl.dart';
import 'features/albums/domain/usecases/get_albums.dart';
import 'features/albums/presentation/bloc/album_bloc.dart';
import 'features/albums/presentation/pages/album_list_page.dart';
import 'features/albums/presentation/pages/album_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = AlbumRemoteDataSourceImpl(client: http.Client());
    final repository = AlbumRepositoryImpl(remoteDataSource: remoteDataSource);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AlbumListPage(),
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final albumId = int.parse(state.pathParameters['id'] ?? '0');
            return AlbumDetailPage(albumId: albumId);
          },
        ),
      ],
    );

    return BlocProvider(
      create: (context) => AlbumBloc(
        getAlbums: GetAlbums(repository),
        repository: repository,
      ),
      child: MaterialApp.router(
        title: 'Album App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          cardTheme: const CardTheme(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
