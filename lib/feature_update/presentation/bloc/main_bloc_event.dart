import 'package:equatable/equatable.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class SendData extends UpdateEvent{


}