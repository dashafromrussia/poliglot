import 'package:flutter/material.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_auth/presentation/bloc/LoadUserBloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_book/presentation/pages/MainWidgets.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class _AuthDataStorage {
  String email = "dariavladimirowna@gmail.com";
  String password = "dvcoL42f";
}

class LoginDataWidget extends StatelessWidget {
  const LoginDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _onAuthViewStateChange,
      child: Provider(
        create: (_) => _AuthDataStorage(),
        child: Scaffold(
          appBar: AppBar(
              leading: GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Icon(Icons.arrow_back,color: Colors.white,),
              ),
            title: const Text('Poliglot'),
          ),
          body: ListView(
            children: const [
              _HeaderWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _onAuthViewStateChange(
      BuildContext context,
      LoginState state,
      ) {
    if (state is LoginSuccessState) {
      Navigator.pushNamed(context, '/main');
    }
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 25),
          /*const Text(
            'In order to use the editing and rating capabilities of TMDb, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: textStyle,
          ),*/
          const SizedBox(height: 5),
       Center(child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children:[
          TextButton(
            //style: AppButtonStyle.linkButton,
            onPressed: () {
              Navigator.pushNamed(context, '/auth');
            },
            child: const Text('Регистрация'),
          ),
          const SizedBox(height: 25),
          /* const Text(
            'If you signed up but didn`t get your verification email.',
            style: textStyle,
          ),*/
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
    Navigator.pushNamed(context, '/forgetpass');
    },
      // style: AppButtonStyle.linkButton,
            child: const Text('Забыли пароль ?'),
          ),
        ]),
    ),

        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
      fillColor: Colors.red,
      focusColor: Colors.red,
      hoverColor: Colors.red,
    );
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const Text(
          'Email',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          maxLength: 50,
          decoration: textFieldDecorator,
          onChanged: (text){ authDataStorage.email = text;
            print(authDataStorage.email);},
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          maxLength: 20,
          decoration: textFieldDecorator,
          obscureText: true,
          onChanged: (text){authDataStorage.password = text;
            print(authDataStorage.password);},
        ),
        const SizedBox(height: 25),
         const  Center(child:const _AuthButtonWidget()),
          //  const SizedBox(width: 30),
      ],
    ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final blocApp = context.watch<AppBloc>();
    final bloc = context.watch<LoginBloc>();
    final authDataStorage = context.read<_AuthDataStorage>();
    const color = Colors.blue;
    final canStartAuth = bloc.state is LoginUnloginState ||
        bloc.state is LoginErrorState;
    final onPressed = canStartAuth
        ? (){ bloc.add(VerifyData(UserLogin(email:authDataStorage.email.trim(),password: authDataStorage.password.trim())));
             //  blocApp.add(const ToggleDrawer('Main'));
    }
        : null;
    final child = bloc.state is LoginProgressState
        ? const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : const Text('Войти в профиль');
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
      ),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((LoginBloc c) {
      final state = c.state;
      return state is LoginErrorState? state.error: null;
    });
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}





/*class AuthDataWidget extends StatefulWidget {
  const AuthDataWidget({Key? key}) : super(key: key);

  @override
  _AuthDataWidgetState createState() =>  _AuthDataWidgetState();
}

class _AuthDataWidgetState extends State<AuthDataWidget> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 // final _nameController = TextEditingController(text:'rina');
 final _nameController = TextEditingController(text:'Irina');
  final _ageController = TextEditingController(text:'45');
  final _emailController = TextEditingController(text:'da@ru');
  final _activityController = TextEditingController(text:'program');
  final _jobController = TextEditingController(text:'program');
  final _storyController = TextEditingController(text:'about me');
  final _passController = TextEditingController(text:'12345678');
  final _confirmPassController = TextEditingController(text:'12345678');
  final _codeController = TextEditingController(text:'');

  final List<String> _countries = ['Russia', 'Ukraine', 'Germany', 'France'];
  final List<String> _languages = ['Русский', 'Английский', 'Немецкий', 'Французский', 'Китайский'];
  String _selectedCountry = 'Russia';
  String _selectedLanguage = 'Русский';




  @override
  void dispose() {
     _nameController.dispose();
    _ageController.dispose();
     _emailController.dispose();
     _activityController.dispose();
    _jobController.dispose();
     _storyController.dispose();
   _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    final bloc = context.watch<AuthBloc>();
    final dataUsers = context.watch<DataUsersBloc>();

    /*if(bloc.state is AuthSendData){
      _showDialog(name:_nameController.text);
    }*/
    // final bloc = context.read<AuthBloc>();
    /*return StreamBuilder<AuthState>(

        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot)
    {*/
   return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          _onState(state);
          // do stuff here based on BlocA's state
        },
      child:Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Register Form'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
             controller:_nameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Введите имя *',
                  hintText: 'Как тебя зовут?',
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _nameController.clear();
                      });
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: _validateName,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                // onSaved: (value)=>newUser.name = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                //  initialValue: "23",
                autofocus: true,
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Ваш возраст*',
                  hintText: 'Сколько Вам лет?',
                  prefixIcon: const Icon(Icons.play_arrow),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _ageController.clear();
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  // FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter(RegExp(r"[0-9]+"),
                      allow: true),
                ],
                validator: _validateAge,

                //  onSaved: (value) => newUser.age = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                //  initialValue: 'program',
                autofocus: true,
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Род деятельности *',
                  hintText: 'Чем ты занимаешься?',
                  prefixIcon: const Icon(Icons.work),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _activityController.clear();
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: _validateActivity,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                //  onSaved: (value) => newUser.activity = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                // initialValue:'programming',
                autofocus: true,
                controller: _jobController,
                decoration: InputDecoration(
                  labelText: 'Профессия *',
                  hintText: 'Кем ты работаешь?',
                  prefixIcon: const Icon(Icons.work_history_outlined),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _jobController.clear();
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: _validateJob,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                //  onSaved: (value) => newUser.job = value!,
              ),
              const SizedBox(height: 20),
              dataUsers.state is EmailVerifyIsTrue ?  const SizedBox()
               : TextFormField(
                onChanged: (text){
                  dataUsers.add(CheckEmail(text));
                },
              controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email адрес',
                  hintText: 'Введите email',
                  icon: Icon(Icons.mail),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                validator: _validateEmail,
                //onSaved: (value) => newUser.email = value!,
              ),
              const SizedBox(height: 10),
             dataUsers.state is CheckRightEmailState ?
             Container(
               child:const Text('Такой email уже зарегистрирован',style:TextStyle(color:Colors.red)),
               padding:const EdgeInsets.symmetric(vertical: 10),
             ):
             const SizedBox(),
            dataUsers.state is CheckWrongEmailState ?  ElevatedButton(
                child: const Text('отправить код'),
                onPressed:() => dataUsers.add(SendCodeEmail(email:_emailController.text)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)
                ),
                //color: Colors.green,
              ):const SizedBox(),
              dataUsers.state is EmailNotValidState ?
              Container(
                child:const Text('Некорректый email',style:TextStyle(color:Colors.red)),
                padding:const EdgeInsets.symmetric(vertical: 10),
              ):
              const SizedBox(),
            dataUsers.state is StartProcessCode && !(dataUsers.state as StartProcessCode).isStop  ?
            Container(
                child:Column(
                    children:[
                TextFormField(
                  //initialValue: 'program',
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Код пришел на Ваш эл.адрес',
                    hintText: 'Введите код',
                    icon: Icon(Icons.mail),
                  ),
                  //keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                //  validator: _validateEmail,
                  //onSaved: (value) => newUser.email = value!,
                ),
                const SizedBox(),
                  Text('${(dataUsers.state as StartProcessCode).minutes}:${(dataUsers.state as StartProcessCode).seconds}'),
                  ElevatedButton(
                    child: const Text('Отправить код'),
                    onPressed:() => dataUsers.add(SendMyCode(code:_codeController.text)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white)
                    ),

                    //color: Colors.green,
                  ),
                ]
                )
              ):const SizedBox(),
              dataUsers.state is EmailVerifyIsTrue ?
              const Text('Адрес эл.почты подтвержден.',style:TextStyle(color:Colors.red)):const SizedBox(),
              dataUsers.state is NotValidCodeState ?
              const Text('Адрес эл.почты не подтвержден.',style:TextStyle(color:Colors.green)):const SizedBox(),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.map),
                    labelText: 'Страна?'),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    child: Text(country),
                    value: country,
                  );
                }).toList(),
                onChanged: (country) {
                  print(country);
                  setState(() {
                    _selectedCountry = country as String;
                    //   newUser.country = country;
                  });
                },
                value: _selectedCountry,
                validator: (val) {
                  return val == null ? 'Please select a country' : null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.home),
                    labelText: 'Родной язык'),
                items: _languages.map((lan) {
                  return DropdownMenuItem(
                    child: Text(lan),
                    value: lan,
                  );
                }).toList(),
                onChanged: (lan) {
                  print(lan);
                  setState(() {
                    _selectedLanguage = lan as String;
                    // newUser.language = lan;
                  });
                },
                value: _selectedLanguage,
                // validator: (val) {
                //   return val == null ? 'Please select a country' : null;
                // },
              ),
              const SizedBox(height: 20),
              TextFormField(
                //   initialValue: 'about me',
                controller: _storyController,
                decoration: const InputDecoration(
                  labelText: 'Life Story',
                  hintText: 'Tell us about your self',
                  helperText: 'Keep it short, this is just a demo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                maxLength: 100,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: '12345678',
                controller: _passController,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Пароль *',
                  hintText: 'Введите пароль',
                  suffixIcon: IconButton(
                    icon:
                    Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  icon: const Icon(Icons.security),
                ),
                validator: _validatePassword,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
            //    onSaved: (value) => newPrivateUser.password = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                //   initialValue: '12345678',
                  controller: _confirmPassController,
                  obscureText: _hidePass,
                  maxLength: 8,
                  decoration: const InputDecoration(
                    labelText: 'Повторите пароль *',
                    hintText: 'Повторите пароль',
                    icon: Icon(Icons.border_color),
                  ),
                  validator: _validatePassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ]
              ),
              const SizedBox(height: 15),
            bloc.state is AuthProgress ?
            Container(child:CircularProgressIndicator(),padding:const EdgeInsets.symmetric(horizontal: 300),):
              ElevatedButton(
                child: const Text('Зарегистрироваться!'),
                onPressed: () => sendData(bloc,dataUsers.state),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)
                ),
                //color: Colors.green,
              ),
             /* ElevatedButton(
                child: const Text('send to email!'),
                onPressed:() => dataUsers.add(const SendCodeEmail(email:'dariavladimirowna@gmail.com')),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)
                ),

                //color: Colors.green,
              ),*/
             /* ElevatedButton(
                child: const Text('отправить код'),
                onPressed:() => dataUsers.add(const SendCodeEmail(email:'dariavladimirowna@gmail.com')),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)
                ),*/

                //color: Colors.green,
              //),
            /* dataUsers.state is StartProcessCode && !(dataUsers.state as StartProcessCode).isStop ?
              Text('${(dataUsers.state as StartProcessCode).minutes}:${(dataUsers.state as StartProcessCode).seconds}'):const SizedBox(),
              ElevatedButton(
                child: const Text('мой код'),
                onPressed:() => dataUsers.add(const SendMyCode(code: '8796')),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)
                ),

                //color: Colors.green,
              ),*/
            ],
          ),
        ),
      ),
    );
  // }
   // );
        }

        void _onState(AuthState state){
        if(state is AuthSendData){
          _showDialog(name: _nameController.text);
        }
        }

   sendData(AuthBloc bloc,UsersDataState state) async{
    print(state);
    // bloc.add(const SendData({'data':'1'}));
    if(state is CheckRightEmailState || state is EmailNotValidState || state is StartProcessCode || state is NotValidCodeState || state is CheckWrongEmailState){
      _showMessage(message: 'Проверьте адрес эл.почты');
      return;
    }
    if (_formKey.currentState!.validate()) {
      // _formKey.currentState!.save();
      final user =  User(name:_nameController.text, job:_jobController.text, activity: _activityController.text,
          email: _emailController.text,country: _selectedCountry,age: _ageController.text,story: _storyController.text,
          language: _selectedLanguage,userid:'4955',date:'20.12.2008', image: 'https://lumpics.ru/wp-content/uploads/2017/11/Programmyi-dlya-sozdaniya-avatarok.png',password: _passController.text );

      bloc.add(SendData(user));
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedCountry');
      print('Story: ${_storyController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }



  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Введите имя.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Введите корректные символы.';
    } else {
      return null;
    }
  }

  String? _validateActivity(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Укажите свой род деятельности';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Введите корректные символы.';
    } else {
      return null;
    }
  }

  String? _validateJob(String? value) {
    final _jobExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Введите,кем Вы работаете.';
    } else if (!_jobExp.hasMatch(value)) {
      return 'Введите корректные символы.';
    } else {
      return null;
    }
  }


  String? _validateEmail(String? value) { //нужно сдел проверку,не повторяется ли адрес и отправка кода на адрес
    if (value == null) {
      return 'Ведите адрес эл. почты';
    } else if (!_emailController.text.contains('@')) {
      return 'Адрес эл.почты не валиден';
    } else {
      return null;
    }
  }

  String? _validateAge(String? value) {
    if (_ageController.text.length == 0) {
      return 'Введите возраст';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
     if (_confirmPassController.text != _passController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
    // До Flutter 2.0
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     duration: Duration(seconds: 5),
    //     backgroundColor: Colors.red,
    //     content: Text(
    //       message,
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.w600,
    //         fontSize: 18.0,
    //       ),
    //     ),
    //   ),
    // );
  }



  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name is now a verified register form',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
               /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  ),
                );*/
              },
              child: const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}*/



/*class AuthDataWidget extends StatelessWidget {
  final String auth;
  final ScreenFactory screenFactory;
  const AuthDataWidget({Key? key,required this.screenFactory, required this.auth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: SafeArea(
        child:  Center(
         child: Row(
         //   mainAxisSize: MainAxisSize.min,
            children:  [
              ElevatedButton(
                  onPressed:(){Navigator.pushNamed(context, '/main'); bloc.add( const ToggleDrawer('Main'));},
                  child: const Text('nav')),
           const  MainWidget(),
           const  ButtonWidget()
            ],
          ),
        )
      ), //drawer: DrawerWidget(widgetNow:context.widget,screenFactory: screenFactory,)
    );
  }
}*/



/*class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      final bloc = context.read<AuthBloc>();
      return StreamBuilder<AuthState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Center( 
              child:(snapshot.requireData as AuthCount).count!=0 ? Text("${(snapshot.requireData as AuthCount).count}age.count."):Text('00'));
        },
      )
      ;
    }
  }*/

/*class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(SendData()),
      child: const Text('AUTH'),
    );
  }
}*/
    /*return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("aaa"),
              Text('main')
            ],
          ),
        ),
      ),
    );
  }
}*/
