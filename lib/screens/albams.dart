import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/bloc/theme/themek_bloc.dart';
import 'package:flutter_api_with_bloc/model/album_model.dart';
import 'package:flutter_api_with_bloc/themes/app_theme.dart';
import '../bloc/album/album_state.dart';
import '../bloc/album/albums_block.dart';
import 'package:flutter_api_with_bloc/bloc/album/albums_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlbumClassState();
  }
}

class AlbumClassState extends State<AlbumClass> {
  bool isdark = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAlbums();
  }

  loadAlbums() async {
    context.read<AlbumsBloc>().add(AlbumEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
        builder: (BuildContext contex, AlbumsState state) {
      return Scaffold(
        appBar: AppBar(
          title: state is AlbumLoadedState
              ? Text(state.titleStr)
              : state is AlbumListErrorstate
                  ? Text('N/A')
                  : defaultStateWidget(),
          actions: [
            Switch(
              value: isdark,
              onChanged: (val) async {
                _setTheme(val);
                isdark = !isdark;
              },
            )
          ],
        ),
        body: state is AlbumLoadedState
            ? loadedStateWidget(state)
            : state is AlbumListErrorstate
                ? errorStateWidget(state)
                : defaultStateWidget(),
      );
    });
  }

  Widget errorStateWidget(AlbumListErrorstate state) {
    final error = state.error;
    String message = '${error.message}\nTap to Retry.';
    return Text(
      message,
    );
  }

  Widget loadedStateWidget(AlbumLoadedState state) {
    List<Rows> albums = state.albums;
    String title = state.titleStr;
    return _list(albums, title);
  }

  Widget defaultStateWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _list(List<Rows> albums, String titleStr) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (_, index) {
        Rows album = albums[index];
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 26.0)
                    ],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: album.imageHref ?? '',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Row(
                        children: [
                          Text(
                            album.title ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        album.description ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ],
          ),
        );
      },
    );
  }

  _setTheme(bool darkTheme) async {
    AppTheme selectedTheme =
        darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    print(darkTheme);
    context.read<ThemekBloc>().add(ThemekEvent(appTheme: selectedTheme));
    //Preferences.saveTheme(selectedTheme);
  }
}
