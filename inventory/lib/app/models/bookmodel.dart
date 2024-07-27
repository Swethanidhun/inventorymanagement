import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str), null);

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  String? author;
  String? availableStock;
  String? description;
  String? genre;
  String? id;
  String? image;
  String? title;
  String? totalStock;

  BookModel({
    this.author,
    this.availableStock,
    this.description,
    this.genre,
    this.id,
    this.image,
    this.title,
    this.totalStock,
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String? id) => BookModel(
    author: json["author"],
    availableStock: json["available-stock"],
    description: json["description"],
    genre: json["genre"],
    id: id, // Assigning the passed id parameter here
    image: json["image"],
    title: json["title"],
    totalStock: json["total-stock"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "available-stock": availableStock,
    "description": description,
    "genre": genre,
    "id": id,
    "image": image,
    "title": title,
    "total-stock": totalStock,
  };
}
