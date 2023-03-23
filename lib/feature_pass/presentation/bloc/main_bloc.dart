import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_pass/domain/usecases/sendCodeToEmail.dart';
import 'package:poliglot/feature_pass/domain/usecases/getUserData.dart';
import 'package:equatable/equatable.dart';

 abstract class PassEvent extends Equatable{
const PassEvent();
  @override
  List<Object> get props => [];
}

class GetMyPassEvent extends PassEvent{
   final String email;
   const GetMyPassEvent(this.email);
}

abstract class PassState extends Equatable{
const PassState();
  @override
  List<Object> get props => [];
}

class ForgetPassState extends PassState{

}

class ProcessSendpassState extends PassState{

}

class ErrorPassState extends PassState{
final String error;
const ErrorPassState(this.error);
}

class TrueEmailState extends PassState{
  final String email;
  const TrueEmailState(this.email);
}

class PasswordSend extends PassState{

}


class PassBloc extends Bloc<PassEvent,PassState>{

  final VerifyEmailData emailData;
  final SendPasswordToEmail sendPassword;

  PassBloc({required this.emailData,required this.sendPassword}) : super(ForgetPassState()) {
    on<GetMyPassEvent>((event,emit)async{
      if(event.email.trim().isEmpty){
        emit(const ErrorPassState('Пустое поле. Введите email'));
        return;
      }else if(!event.email.contains('@')){
        emit(const ErrorPassState('Невалидное значение. Проверьте наличие @'));
        return;
      }
      emit(ProcessSendpassState());
      final data = await emailData.callData(VerifyEmailParams(email: event.email));
      emit(data.fold(
              (failure) =>const ErrorPassState('Такой адрес не зарегистрирован в системе.'),
              (email) =>TrueEmailState(email)));
       if(state is TrueEmailState){
         String password = '';
         const String possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxxy0123456789"; //ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
         for (int i = 0; i < 8; i++){
           password = password + possible[Random().nextInt(59) + 1];
         }
         final sendPass =await sendPassword.callData(PasswordToEmailParams(password: password, email:(state as TrueEmailState).email));
         emit(sendPass.fold(
                 (failure) =>const ErrorPassState('Не удалось отправить пароль, попробуйте еще раз.'),
                 (email) =>PasswordSend()));
       }else if(state is ErrorPassState){
         return;
       }

    });
  }


}
