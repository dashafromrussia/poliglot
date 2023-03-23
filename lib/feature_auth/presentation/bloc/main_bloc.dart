import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_auth/domain/usecases/sendUserData.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/domain/usecases/getUserData.dart';


class AuthBloc extends Bloc<AuthEvent,AuthState>{

  final SendUserData userdata;

  AuthBloc({required this.userdata}) : super(AuthUnloadUsers()) {
    on<AuthEvent>((event,emit)async{
      if(event is SendData){
        await onAuthSendDataEvent(event, emit);
      }
    });

  }


  Future<void> onAuthSendDataEvent(
      SendData event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthProgress());
    await Future.delayed(const Duration(seconds: 10), () {
      print('${state}duration');
    });
    print('${state} после duration');
    final data = await userdata.callData(UserParams(user: event.newUser));
    emit(data.fold(
            (failure) => AuthErrorState(),
            (person) => AuthSendData()));
    print("${state}state");

  }
}
