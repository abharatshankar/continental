import 'dart:io';

import 'package:flutter_api_with_bloc/model/album_model.dart';

import 'album_state.dart';
import 'package:flutter_api_with_bloc/bloc/album/albums_events.dart';
import 'package:flutter_api_with_bloc/repositories/Albumsrepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsBloc extends Bloc<AlbumEvents, AlbumsState> {
  final Albumsrepository albumsrepository;
  late List<Rows> listAlbums;
  late AlbumsModel totalResponse;
  AlbumsBloc({required this.albumsrepository}) : super(AlbumInitialState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async* {
    switch (event) {
      case AlbumEvents.fetchAlbums:
        yield AlbumLoadingState();

        try {
          totalResponse = await albumsrepository.getAlbumsList();

          yield AlbumLoadedState(
              albums: totalResponse.rows ?? [],
              titleStr: totalResponse.title ?? '');
        } on SocketException {
          yield AlbumListErrorstate(
            error: ('No Internet'),
          );
        } on HttpException {
          yield AlbumListErrorstate(
            error: ('No Service'),
          );
        } on FormatException {
          yield AlbumListErrorstate(
            error: ('No Format Exception'),
          );
        } catch (e) {
          print(e.toString());
          yield AlbumListErrorstate(
            error: ('Un Known Error ${e.toString()}'),
          );
        }
        break;
    }
  }
}
