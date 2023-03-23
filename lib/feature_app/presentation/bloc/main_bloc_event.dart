import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

/*class AppData extends AppEvent {

}*/

class ToggleDrawer extends AppEvent {
 final String select;

const ToggleDrawer(this.select);
 @override
 List<Object> get props => [select];
}

class ExitEvent extends AppEvent{

}