import 'package:flutter_api_with_bloc/api/service_api.dart';
import 'package:flutter_api_with_bloc/model/album_model.dart';

class Albumsrepository {
  Future<AlbumsModel> getAlbumsList() {
    return AlbumService().getAlbums();
  }
}
