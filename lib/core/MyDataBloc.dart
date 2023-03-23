import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:poliglot/core/domain/usecases/MyData.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/domain/usecases/updateUserUsecase.dart';

abstract class MyDataEvent extends Equatable{
  const MyDataEvent();
  @override
  List<Object> get props => [];
}

class GetMyDataEvent extends MyDataEvent{

}

abstract class MyDataState extends Equatable{
  const MyDataState();
  @override
  List<Object> get props => [];
}

class GetMyDataState extends MyDataState{

}

class MyDataSuccessState extends MyDataState{
  final User user;
 const MyDataSuccessState(this.user);
}


class ErrorMyDataState extends MyDataState{

}

class BeginMyDataState extends MyDataState{
 const BeginMyDataState();
}
///////////////////////////////////////////////////////


class UpdateMyDataEvent extends MyDataEvent{
  final User user;
  const UpdateMyDataEvent(this.user);
}




class UpdateProgress extends MyDataState{
  const UpdateProgress();
}
class UpdateErrorState extends MyDataState{
  const UpdateErrorState();
}

class UpdateSendData extends MyDataState{
  const UpdateSendData();
}


class MyDataBloc extends Bloc<MyDataEvent,MyDataState>{
  final GetMyData myData;
 final UpdateUser userdata;

  MyDataBloc({required this.myData,required this.userdata}) : super(GetMyDataState()) {
   print('CREATE');
    on<MyDataEvent>((event,emit)async{
      if(event is GetMyDataEvent) {
        emit(const BeginMyDataState());
        print('begin');
        final data = await myData.callData(const MyDataParams());
        emit(data.fold(
                (failure) => ErrorMyDataState(),
                (users) => MyDataSuccessState(users[0])));
      } else if(event is UpdateMyDataEvent){
        await updateData(event, emit);
      }
    });
    add(GetMyDataEvent());
  }

  Future<void> updateData(
      UpdateMyDataEvent event,
      Emitter<MyDataState> emit,
      ) async {
    emit(const UpdateProgress());
    await Future.delayed(const Duration(seconds:5), () {
      print('${state}duration');
    });
    print('${state} после duration');
    final data = await userdata.callData(UpdateUserParams(user: event.user));
    emit(data.fold(
            (failure) => const UpdateErrorState(),
            (person) =>const UpdateSendData()));
    //  myDataBloc.add(GetMyDataEvent());
    print("${state}state");

  }



}
