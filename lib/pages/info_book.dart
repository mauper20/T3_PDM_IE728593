import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class InfoBook extends StatefulWidget {
  final dynamic infBook;
  const InfoBook({super.key, this.infBook});

  @override
  State<InfoBook> createState() => _SelecBook();
}

class _SelecBook extends State<InfoBook> {
  bool title = false;
  bool desc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de libro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir contenido',
            onPressed: () {
              shareBook(context, widget.infBook);
            },
          ),
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                "${widget.infBook["volumeInfo"]["imageLinks"] != null ? widget.infBook["volumeInfo"]["imageLinks"]["thumbnail"] : "https://library.msu.ac.zw/img/nocover.png"}",
                fit: BoxFit.fitHeight,
                height: 350,
              ),
              MaterialButton(
                onPressed: () {
                  title = !title;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Text(
                    "${widget.infBook["volumeInfo"]["title"] ?? "Title not available"}",
                    style: const TextStyle(fontSize: 32),
                    overflow: title ? null : TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "${widget.infBook["volumeInfo"]["publishedDate"] ?? "Date not available"}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "Paginas: ${widget.infBook["volumeInfo"]["pageCount"] ?? "Page number not available"}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  desc = !desc;
                  setState(() {});
                },
                child: Text(
                  "${widget.infBook["volumeInfo"]["description"] ?? "Description not available"}",
                  maxLines: desc ? 30 : 4,
                  overflow: desc ? null : TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void shareBook(BuildContext context, dynamic bookData) async {
    await FlutterShare.share(
        title:
            "${widget.infBook["volumeInfo"]["title"] ?? "Title not available"}",
        text:
            'Libro: ${widget.infBook["volumeInfo"]["title"] ?? "Title not available"}\nPaginas: ${widget.infBook["volumeInfo"]["pageCount"] ?? "Page number not available"}',
        linkUrl: "${widget.infBook["selfLink"]}",
        chooserTitle: 'Compartir con:');
  }
}
