import 'package:equatable/equatable.dart';


abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookCount extends BookState {
  final int count;
 const BookCount({required this.count});

  @override
  List<Object> get props => [count];

BookCount copyWith({
    int? currentCount,
  }) {
    return BookCount(
      count: currentCount ?? count,
    );
  }
}


