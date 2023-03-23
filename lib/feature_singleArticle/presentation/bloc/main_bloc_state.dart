import 'package:equatable/equatable.dart';


abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesCount extends ArticlesState {
  final int count;
 const ArticlesCount({required this.count});

  @override
  List<Object> get props => [count];

ArticlesCount copyWith({
    int? currentCount,
  }) {
    return ArticlesCount(
      count: currentCount ?? count,
    );
  }
}


