import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/core/MyDataBloc.dart';
import 'package:poliglot/feature_update/domain/usecases/upateUserusecase.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/domain/usecases/getUserData.dart';

abstract class UpdateEvent extends Equatable{
  const UpdateEvent();
  @override
  List<Object> get props => [];
}

class UpdateMyDataEvent extends UpdateEvent{
  final User user;
  const UpdateMyDataEvent(this.user);
}

abstract class UpdateState extends Equatable{
  const UpdateState();
  @override
  List<Object> get props => [];
}

class UpdateBegin extends UpdateState{
  const UpdateBegin();
}


class UpdateProgress extends UpdateState{
  const UpdateProgress();
}
class UpdateErrorState extends UpdateState{
  const UpdateErrorState();
}

class UpdateSendData extends UpdateState{
  const UpdateSendData();
}

class UpdateBloc extends Bloc<UpdateEvent,UpdateState>{
  final UpdateUser userdata;

  UpdateBloc({required this.userdata}) : super(const UpdateBegin()) {
    on<UpdateEvent>((event,emit)async{
      if(event is UpdateMyDataEvent){
        await updateData(event, emit);
      }
    });

  }


  Future<void> updateData(
      UpdateMyDataEvent event,
      Emitter<UpdateState> emit,
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



