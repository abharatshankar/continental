// To parse this JSON data, do
//
//     final albumsModel = albumsModelFromJson(jsonString);

import 'dart:convert';

AlbumsModel albumsModelFromJson(String str) =>
    AlbumsModel.fromJson(json.decode(str));
List<Rows> modelFromJson(String str) =>
    List<Rows>.from(json.decode(str).map((x) => AlbumsModel.fromJson(x)));

String albumsModelToJson(AlbumsModel data) => json.encode(data.toJson());

class AlbumsModel {
  AlbumsModel({
    this.title,
    this.rows,
  });

  String? title;
  List<Rows>? rows;

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
        title: json["title"],
        rows: json["rows"] != null
            ? List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rows": List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Rows {
  Rows({
    this.title,
    this.description,
    this.imageHref,
  });

  String? title;
  String? description;
  String? imageHref;

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        imageHref: json["imageHref"] == null ? null : json["imageHref"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "imageHref": imageHref == null ? null : imageHref,
      };
}
