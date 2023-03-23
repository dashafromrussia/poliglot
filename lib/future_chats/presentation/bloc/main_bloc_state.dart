import 'package:equatable/equatable.dart';


abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsCount extends ChatsState {
  final int count;
 const ChatsCount({required this.count});

  @override
  List<Object> get props => [count];

ChatsCount copyWith({
    int? currentCount,
  }) {
    return ChatsCount(
      count: currentCount ?? count,
    );
  }
}


