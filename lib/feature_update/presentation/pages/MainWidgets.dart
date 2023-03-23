import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poliglot/core/MyDataBloc.dart';
import 'package:poliglot/entities/user.data.dart';
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
//import 'package:poliglot/feature_update/presentation/bloc/main_bloc.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;

class UpdateDataWidget extends StatefulWidget {
  final Widget drawerWidget;
  final User user;
  const UpdateDataWidget({Key? key, required this.drawerWidget, required this.user}) : super(key: key);

  @override
  _UpdateDataWidgetState createState() =>  _UpdateDataWidgetState();
}
// User(name: '', job: '', activity: '', email:'', country: '', age: '', story: '', language: '', userid: '', date: '', image:'', password: '');
class  _UpdateDataWidgetState extends State<UpdateDataWidget> {

  _UpdateDataWidgetState();

  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String age = '';
  String email = '';
  String activity = '';
  String job = '';
  String story = '';
  String pass = '';
  String confirmPass= '';
  String code = '';

  XFile? images;
  Uint8List? imgBytes;
  String? filePath;

  final List<String> _countries = ['Russia', 'Ukraine', 'Germany', 'France'];
  final List<String> _languages = ['Русский', 'Английский', 'Немецкий', 'Французский', 'Китайский'];
  String _selectedCountry = '';
  String _selectedLanguage = '';

@override
void initState(){
  super.initState();
}


  @override
  void dispose() {
    super.dispose();
  }

  void _handleImageSelection() async {
    print('ttt');
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    print('reeesss${result}ressss');
    if (result != null) {
      final bytes = await result.readAsBytes().then((value) => imgBytes = value);
      final image = await decodeImageFromList(bytes);
      setState(() {
        //final byteImage  = image.toByteData();
        images = result;
        print('bbb${bytes}bbbb');
      });
      print('iiiiiiiiiiii${images}iiiiiiiiiiiiiiiii');
      /*final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );*/

    }
  }
  Future<String?> getStringImg()async{
    FirebaseStorage.instance.refFromURL("gs://glot-c5df4.appspot.com/images/me").getDownloadURL().then((value){
      return value;
    });
  }


  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      return null;
    }

    UploadTask uploadTask;
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('avatars')
        .child('/${file.name}');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }


  Future<void> handleUploadType() async {
    if(images==null) return;
    //  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    UploadTask? task = await uploadFile(images);
    Stream<TaskSnapshot?>? streams = task?.snapshotEvents;
    StreamSubscription<TaskSnapshot?>? sub;
    sub = streams?.listen((event) {
      if(event?.bytesTransferred==event?.totalBytes){
        geturlfile(images);
        sub?.cancel();
      }
    });

  }

  Future<void>geturlfile(XFile? file)async{

    if(images==null) return null;

    await FirebaseStorage.instance.refFromURL("gs://glot-c5df4.appspot.com/images/${file?.name}").getDownloadURL().then((value){

      setState(() {
        filePath = value;
      });
    });

    print(filePath);
  }



  @override
  Widget build(BuildContext context) {

    final bloc = context.read<MyDataBloc>();

    /*if(bloc.state is UpdateSendData){
      _showDialog(name:name);
    }*/

    return StreamBuilder<MyDataState>(

        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot)
    {
      return BlocListener<MyDataBloc, MyDataState>(
          listener: (context, state) {
        _onState(state);
      },
  child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Обновить данные'),
          centerTitle: true,
        ),
        body:
     Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
               initialValue: widget.user.name,
                autofocus: true,
                onChanged: (text){
                  setState(() {
                    name =text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Ваше имя *',
                  hintText: 'Как тебя зовут?',
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        name ='';
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
                  initialValue: widget.user.age,
                autofocus: true,
                onChanged: (text){
                  setState(() {
                    age=text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Ваш возраст*',
                  hintText: 'Сколько Вам лет?',
                  prefixIcon: const Icon(Icons.play_arrow),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        age='';
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
                 initialValue: widget.user.activity,
                autofocus: true,
                onChanged: (text){
                  setState(() {
                    activity =text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Род деятельности *',
                  hintText: 'Чем ты занимаешься?',
                  prefixIcon: const Icon(Icons.work),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      activity='';
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
                 initialValue: widget.user.job,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Профессия *',
                  hintText: 'Кем ты работаешь?',
                  prefixIcon: const Icon(Icons.work_history_outlined),
                  suffixIcon: GestureDetector(
                    onTap: () {
                     job='';
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
                value:_selectedCountry==''? widget.user.country:_selectedCountry,
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
                value: _selectedLanguage=='' ? widget.user.language:_selectedLanguage,
                // validator: (val) {
                //   return val == null ? 'Please select a country' : null;
                // },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.user.story,
                onChanged: (text){
                  setState(() {
                    story ='';
                  });
                },
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
              const Text('Введите пароль,если хотите его поменять.'),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (text){
                  setState(() {
                    pass =text;
                  });
                },
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
               // validator: _validatePassword,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                //    onSaved: (value) => newPrivateUser.password = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                //   initialValue: '12345678',
                  onChanged: (text){
                    setState(() {
                      confirmPass =text;
                    });
                  },
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
              imgBytes==null ?SizedBox():Container(
                width: 40,
                height: 40,
                child: imgBytes!=null ? Image.memory(imgBytes as Uint8List,height: 100,width: 100,):Text('nnn'),
              ) ,
              const SizedBox(height: 5,),
              ElevatedButton(
                child: const Text('Обновить фото'),
                onPressed: () => sendData(bloc, widget.user),
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    textStyle: const TextStyle(color: Colors.white)
                ),
                //color: Colors.green,
              ),
              const SizedBox(height: 10,),
              bloc.state is UpdateProgress ?
              Container(child:CircularProgressIndicator(),padding:const EdgeInsets.symmetric(horizontal: 300),):
              ElevatedButton(
                child: const Text('Обновить данные'),
                onPressed: () => sendData(bloc, widget.user),
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    textStyle: const TextStyle(color: Colors.white)
                ),
                //color: Colors.green,
              ),
              bloc.state is UpdateErrorState ? const Text('Данные не обновлены. Попробуйте еще раз', style: TextStyle(color:Colors.red ),): const SizedBox(),
            ],
          ),
        ),
      ),
    );
     }
     );
  }

  void _onState(MyDataState state){
    if(state is UpdateSendData){
      _showDialog(name: name);
    }
  }

  sendData(MyDataBloc bloc,User widget) async{
    print(widget.email);
    print(widget.name);
    if (_formKey.currentState!.validate()) {
     await handleUploadType();
     /* if(pass.trim().isEmpty){
        _showMessage(message: 'Проверьте поля ввода пароля');
        return;
      }*/
      // _formKey.currentState!.save();
      final user =  User(name:name.trim(), job:job.trim().isEmpty? widget.job:job.trim(), activity: activity.trim(),
          email: widget.email,country: _selectedCountry.isEmpty? widget.country:_selectedCountry,age: age.trim(),story: story.trim().isEmpty ? widget.story :story.trim(),
          language: _selectedLanguage.isEmpty ? widget.language:_selectedLanguage,userid:widget.userid,date:widget.date, image:filePath != null ? filePath as String :widget.image,password: pass.trim().isEmpty? widget.password:pass.trim());
     print(user.email);
     print(user.name);
      bloc.add(UpdateMyDataEvent(user));
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }



  String? _validateName(String? value) {
    setState(() {
      if(value is String)
        name = value;
    });
  print('${value}VALIDATEEE');
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
setState(() {
  if(value is String)
  activity = value;
});
    print('${value}VALIDATEEE');
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
    setState(() {
      if(value is String)
        job = value;
    });
    print('${value}VALIDATEEE');
    final _jobExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Введите,кем Вы работаете.';
    } else if (!_jobExp.hasMatch(value)) {
      return 'Введите корректные символы.';
    } else {
      return null;
    }
  }


 /* String? _validateEmail(String? value) { //нужно сдел проверку,не повторяется ли адрес и отправка кода на адрес
    if (value == null) {
      return 'Ведите адрес эл. почты';
    } else if (!email.contains('@')) {
      return 'Адрес эл.почты не валиден';
    } else {
      return null;
    }
  }*/

  String? _validateAge(String? value) {
    setState(() {
      if(value is String)
        age = value;
    });
    print('${value}VALIDATEEE');
    if (age.isEmpty == 0) {
      return 'Введите возраст';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    print('${value}VALIDATEEE');
    print('${pass}pass');
    print('${confirmPass==pass}passconnn');
   /* if(pass.trim().isEmpty || confirmPass.trim().isEmpty){
      return 'Введите пароль!';
    }*/
    if (confirmPass!= pass) {
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
                Navigator.pushNamed(context, '/main');
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
}


/*import 'package:flutter/material.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_update/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_update/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_update/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/navigation/MainNavigation.dart';


class UpdateDataWidget extends StatelessWidget {
  final Widget drawerWidget;
  final User user;
  const UpdateDataWidget({Key? key, required this.drawerWidget, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(user.name);
    /*final blocApp = context.watch<AppBloc>();
    blocApp.add(const ToggleDrawer('Update'));*/
    return Scaffold(
        appBar: AppBar(
          title: const Text('Обновить данные'),
        ),
        body: SafeArea(
          child: Center(
            child: Row(
              //   mainAxisSize: MainAxisSize.min,
              children: const [
                //  MainWidget(),
                //  ButtonWidget()
                Text('aaa')
              ],
            ),
          ),
        ),
       // drawer: drawerWidget
    );
  }
}*/



