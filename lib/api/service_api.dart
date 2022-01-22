import 'dart:convert';
import 'package:flutter_api_with_bloc/model/album_model.dart';
import 'package:http/http.dart' as http;

abstract class ServiceApi {
  Future<AlbumsModel> getAlbums();
}

class AlbumService extends ServiceApi {
  @override
  Future<AlbumsModel> getAlbums() async {
    var uri = Uri.parse(
        "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json");
    final response = await http.get(uri);

    var responseData = json.decode(response.body);
    final albums = AlbumsModel.fromJson(responseData);

    return albums;
  }
}
