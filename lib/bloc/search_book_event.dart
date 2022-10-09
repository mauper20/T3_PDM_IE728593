part of 'search_book_bloc.dart';

abstract class SearchBookEvent extends Equatable {
  const SearchBookEvent();

  @override
  List<dynamic> get props => [];
}

class SearchingBookEvent extends SearchBookEvent {
  final String titleSearch;
  const SearchingBookEvent({required this.titleSearch});

  @override
  List<dynamic> get props => [titleSearch];
}
