import 'package:equatable/equatable.dart';


abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateCount extends UpdateState {
  final int count;
 const UpdateCount({required this.count});

  @override
  List<Object> get props => [count];

UpdateCount copyWith({
    int? currentCount,
  }) {
    return UpdateCount(
      count: currentCount ?? count,
    );
  }
}


