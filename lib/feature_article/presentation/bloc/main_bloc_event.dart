import 'package:equatable/equatable.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class SendData extends ArticlesEvent{


}