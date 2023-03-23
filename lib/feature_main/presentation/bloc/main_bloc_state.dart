import 'package:equatable/equatable.dart';


abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainCount extends MainState {
  final int count;
 const MainCount({required this.count});

  @override
  List<Object> get props => [count];

MainCount copyWith({
    int? currentCount,
  }) {
    return MainCount(
      count: currentCount ?? count,
    );
  }
}


