import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_login/domain/usecases/sendUserData.dart';
import 'package:poliglot/feature_login/domain/entities/authUser_parser.dart';
import 'package:poliglot/feature_login/domain/usecases/getUserData.dart';
import 'package:poliglot/feature_login/domain/usecases/isAuth.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  final GetLoginData userdata;
  final IsAuth authData;

  LoginBloc({required this.userdata,required this.authData}) : super(LoginUnloginState()) {
    on<LoginEvent>((event,emit)async{
      if(event is IsAuthorized){
        final data = await authData.callData(const AuthParams());
        emit(data.fold(
                (failure) => const LoginErrorState('Ошибка сервера'),
                (person) =>person ? LoginSuccessState():LoginUnloginState()));
      }
      else if(event is VerifyData){
        await LoginUserEvent(event, emit);
      }
    });
     add(IsAuthorized());
  }

  bool _isValid(String email, String password) =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  Future<void>LoginUserEvent(
      VerifyData event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginProgressState());
    bool isValid = _isValid(event.user.email, event.user.password);
    if(!isValid){
      emit(const LoginErrorState('Зполните поля'));
      return;
    }
    await Future.delayed(const Duration(seconds: 5), () {
      print('${state}duration');
    });
    print('${state} после duration');
    final data = await userdata.callData(DataParams(user: event.user));
    emit(data.fold(
            (failure) =>const LoginErrorState('Ошибка сети. Повторите еще раз'),
            (person) =>person ? LoginSuccessState():const LoginErrorState('Неверные данные!')));
    print("${state}state");

  }
}
