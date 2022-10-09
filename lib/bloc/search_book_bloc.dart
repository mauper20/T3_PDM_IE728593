import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../pages/repo.dart';

part 'search_book_event.dart';
part 'search_book_state.dart';

class SearchBookBloc extends Bloc<SearchBookEvent, SearchBookState> {
  SearchBookState get estate => SearchBookInitialState();
  final RepoBook bookRep = RepoBook();

  SearchBookBloc() : super(SearchBookInitialState()) {
    on<SearchingBookEvent>(_searchBook);
  }

  Future<dynamic> _searchBook(SearchingBookEvent event, Emitter emit) async {
    emit(SearchingState());

    String titleBook = event.titleSearch;
    dynamic listB;

    try {
      listB = await bookRep.getBooks(titleBook);
      if (listB["items"] == null) {
        throw Exception();
      }
      emit(FoundInSearchState(findBooks: listB["items"]));
    } catch (e) {
      emit(
        const ErrorInSearchingState(errMess: "sucedio un error en la busqueda"),
      );
    }
  }
}
