import 'dart:convert';

import 'package:http/http.dart';

class RepoBook {
  static final RepoBook repoBook = RepoBook._internal();
  factory RepoBook() => repoBook;
  RepoBook._internal();

  Future<dynamic> getBooks(String titleBook) async {
    dynamic bList;
    final req = Uri(
        scheme: "https",
        host: "www.googleapis.com",
        path: "books/v1/volumes",
        queryParameters: {"q": titleBook});
    try {
      dynamic response = await get(req);
      bList = jsonDecode(response.body);
      print(bList);
      return bList;
    } catch (e) {
      throw "hubo un error";
    }
  }
}
