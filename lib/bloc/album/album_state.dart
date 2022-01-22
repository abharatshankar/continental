import 'package:equatable/equatable.dart';
import 'package:flutter_api_with_bloc/model/album_model.dart';

abstract class AlbumsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AlbumLoadingState extends AlbumsState {}

class AlbumInitialState extends AlbumsState {}

class AlbumLoadedState extends AlbumsState {
  final String titleStr;
  final List<Rows> albums;
  AlbumLoadedState({required this.albums, required this.titleStr});
}

class AlbumListErrorstate extends AlbumsState {
  final error;
  AlbumListErrorstate({this.error});
}
