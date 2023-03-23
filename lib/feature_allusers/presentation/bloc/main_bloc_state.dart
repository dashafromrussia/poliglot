import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

/*class AppCount extends AppState {
  final int count;
 const AppCount({required this.count});

  @override
  List<Object> get props => [count];

AppCount copyWith({
    int? currentCount,
  }) {
    return AppCount(
      count: currentCount ?? count,
    );
  }
}*/

class ToggleState extends AppState {
final  Map<String,Color> selects;
const ToggleState(this.selects);


  @override
  List<Object> get props => [selects];


}
