import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_auth/domain/usecases/getUserData.dart';
import 'package:poliglot/feature_auth/domain/usecases/sendCodeToEmail.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/entities/user.data.dart';

abstract class UsersDataState extends Equatable {
  const UsersDataState();

  @override
  List<Object> get props => [];
}


class UnloadUsersState extends UsersDataState {

}

class LoadUsersState extends UsersDataState {
final List<User> users;
 const LoadUsersState(this.users);
}

class LoadUsersError extends UsersDataState{

}

class CheckRightEmailState extends UsersDataState{

}

class CheckWrongEmailState extends UsersDataState{

}

class EmailNotValidState extends UsersDataState{

}
class EmailVerifyIsTrue extends UsersDataState{

}

class NotValidCodeState extends UsersDataState{

}

abstract class DataUsersEvent extends Equatable {
  const DataUsersEvent();

  @override
  List<Object> get props => [];
}

class GetLoadUsers extends DataUsersEvent {

}

class CheckEmail extends DataUsersEvent {
  final String email;
  const CheckEmail(this.email);
}


class SendCodeEmail extends DataUsersEvent {
final String email;
const SendCodeEmail({required this.email});
}

class SendMyCode extends DataUsersEvent {
  final String code;
  const SendMyCode({required this.code});
}

class StartProcessCode extends UsersDataState {
  final int minutes;
  final int seconds;
  final bool isStop;
 final String code;
  const StartProcessCode(
      {required this.minutes, required this.seconds, required this.isStop,required this.code});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is StartProcessCode &&
              runtimeType == other.runtimeType &&
              seconds == other.seconds;

  @override
  int get hashCode => super.hashCode ^ seconds.hashCode;

  StartProcessCode copyWith({
    int? minutes,
    int? seconds,
    bool? isStop,
    String? code
  }) {
    return StartProcessCode(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isStop: isStop ?? this.isStop,
      code: code ?? this.code
    );
  }
}

class DataUsersBloc extends Bloc<DataUsersEvent,UsersDataState>{

  final GetUserData getData;
  final SendCodeToEmail sendCode;

  List<User> users = [];
  bool checkMail = false;

  DataUsersBloc({required this.getData,required this.sendCode}) : super(UnloadUsersState()) {
    on<DataUsersEvent>((event,emit)async{
     if(event is GetLoadUsers){
        await onGetDataEvent(event, emit) ;
      }else if(event is CheckEmail){
       checkEmail(event, emit);
     }else if(event is SendCodeEmail){
       await sendCodeToEmail(event, emit);
     }else if(event is SendMyCode){
       emit(StartProcessCode(minutes: 0, seconds: 0, isStop: true, code:event.code));
    //  emit(StopTimer(event.code));
     }
    });
    add(GetLoadUsers());
  }
  Future<void> onGetDataEvent(DataUsersEvent event,
      Emitter<UsersDataState> emit)async{
    final data = await getData.callData(const UserDataParams());
    emit(data.fold(
            (failure) => LoadUsersError(),
            (users) => LoadUsersState(users)));
            users.addAll((state as LoadUsersState).users);
            print('load${users}load');
  }

 void checkEmail(DataUsersEvent event,
      Emitter<UsersDataState> emit){
    print('${(event as CheckEmail).email}');
    print(users.where((element) => element.email == (event as CheckEmail).email).toList().length);
    if(users.where((element) => element.email.toString() == (event as CheckEmail).email).toList().length!=0){
      emit(CheckRightEmailState());
     checkMail = true;
    }else{
      emit(CheckWrongEmailState());
    }

  }
  Future<void> sendCodeToEmail(SendCodeEmail event,
      Emitter<UsersDataState> emit)async{
    ////////////////////////////
    //int max = 61;
    int max = 5;
    String code = '';
    const String possible = "0123456789"; //ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
    for (int i = 0; i < 4; i++){
      code = code+possible[Random().nextInt(max) + 1];
    }
    ///////////////////////////
    if(!event.email.contains('@') || checkMail || code==''){
      emit(EmailNotValidState());
      return;
    }
     emit(const StartProcessCode(minutes: 1, seconds: 10, isStop: false,code:''));
   final data = await sendCode.callData(EmailCodeParams(code: code, email: event.email));
   String? rightCode = await countDownTimer();
    emit(data.fold(
            (failure) => CheckRightEmailState(),
            (data) =>EmailVerifyIsTrue()));
    if(rightCode is String && rightCode.trim()==code.trim()&& state is EmailVerifyIsTrue){
      print('goood');
    }else{
      emit(NotValidCodeState());
    }
    print(rightCode);
     print(code.trim());
     print(state);
  }

    Future<String?>countDownTimer() async {
    //(state as StartProcessCode);
    for (int x = 20; x > 0; x--) {
     if((state as StartProcessCode).isStop) return (state as StartProcessCode).code.trim();
      //if((state as StartProcessCode).isStop)break;
      await Future.delayed(const Duration(seconds: 1)).then((_) {
        if((state as StartProcessCode).seconds==1 && (state as StartProcessCode).minutes > 0){
          final minutes = (state as StartProcessCode).minutes-1;
          emit(StartProcessCode(minutes: minutes, seconds: 10, isStop: false,code:''));
        }
        if((state as StartProcessCode).seconds==0 && (state as StartProcessCode).minutes == 0)return '';
        final seconds = (state as StartProcessCode).seconds - 1;
        emit((state as StartProcessCode).copyWith(seconds: seconds));
        print('${(state as StartProcessCode).minutes}:${(state as StartProcessCode).seconds}');
      });
    }
  }


}

