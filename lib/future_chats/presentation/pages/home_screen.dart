import 'dart:async';
import 'dart:core';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/allchat_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/redirect.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_user_bloc.dart';
import 'package:poliglot/generalFunction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poliglot/future_chats/presentation/bloc/home_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:widget_size/widget_size.dart';
import 'package:widget_finder/widget_finder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;
class MessageScreen extends StatelessWidget {
  final Map arg;
  const MessageScreen({super.key,required this.arg});

  @override
  Widget build(BuildContext context) {
   // final user = FirebaseAuth.instance.currentUser;
    final userStatus = context.watch<StatusUserBloc>();
    final AllchatsBloc blocall = context.watch<AllchatsBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: userStatus.state is OnlineUserState? Text(arg['name'].toString(),style: TextStyle(color: Colors.deepOrange)):
        Text(arg['name'].toString(),style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
       child: Column(
          children: <Widget>[
          /*  Center(
                child: (user == null)
                    ? const Text("Контент для НЕ зарегистрированных в системе")
                    : ElevatedButton(onPressed:()async{
                  await getName();
                  print('aa');
                }, child: Text('data'))
              //child: Text('Контент для НЕ зарегистрированных в системе'),
            ),*/
            Expanded(child:MultiBlocProvider(
              providers: [
                BlocProvider<MessageBloc>(
                    create: (context) =>MessageBloc(idchat:arg['idchat'].toString())),
                BlocProvider<RedirectBloc>(
                    create: (context) =>RedirectBloc()),
              ],
              child:  UserInfo(),
            )
            ),
          ],
        ),

      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  TextEditingController messageController = TextEditingController();
  late AutoScrollController controller;
  final scrollDirection = Axis.vertical;
   bool isScrollHigher = false;
     XFile? images;
  Uint8List? imgBytes;
  String? filePath;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
/*viewportBoundaryGetter: () =>
Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),*/
axis: scrollDirection);
  controller.addListener((){
    whatsPixels();
  });
  }

  void whatsPixels(){ //прослушка на пиксели
   Size sizeHeight =  context.size is Size ? context.size as Size: const Size(0.0, 0.0);
    if(controller.offset > /*sizeHeight.height*/10.0 && isScrollHigher == false){
      print('QQQQ');
      setState(() {
        isScrollHigher = true;
      });
    }else if(controller.offset==0.0 && isScrollHigher == true){
      print('AAAA');
      setState(() {
        isScrollHigher = false;
      });
    }
   if(controller.offset == 0.0) {
    // showedMovieAtIndex(cookie);
   }
    print('${sizeHeight.height}scrl${controller.offset}');
    print('${context.size}sizeeeeeeeeeee');
  }

  Future _scrollToCounter(int index,String data) async { //скролл до эл с опреределенным индексом
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);
    if(data == 'toMessage'){
      controller.highlight(index);
    }
  }

Future<void> getPhoto() async {
  /*FirebaseFirestore.instance.collection("chats").doc('upgZpr0w3zeUbg0srRuq').collection('mrs').get().then((value) => {
  for (var doc in value.docs) {
      print("${doc.id} => ${doc.data()}")
}
  });*/
}


  /*Future<void>getName()async {
    print('begin');
    final ref = FirebaseFirestore.instance;

    await ref.collection('messages').where('name', isEqualTo: 'dasha').where(
        'to', isEqualTo: 'dina').get().then((event) {
      data = data + event.docs.toList();
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    await ref.collection('messages').where('name', isEqualTo: 'dina').where(
        'to', isEqualTo: 'dasha').get().then((event) {
      data = data + event.docs.toList();
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

@override
void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }*/

  /*StreamBuilder<List<QuerySnapshot>>(
                      stream: totalRef,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<QuerySnapshot>> snapshotList) {} )*/
/*StreamBuilder<List<QuerySnapshot>>(
      stream:(bloc.state as LoadArticleProgress).stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children:snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> one = document.data()! as Map<String, dynamic>;
            print(one);
            return ListTile(
              title: Text(one['name']),
              subtitle: Text(one['surname']),
            );
          }).toList(),
        );
      },
    )*/

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  void _handleAttachmentPressed(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  //_handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget build(BuildContext context) {
    final bloc = context.watch<MessageBloc>();
    final cookieBloc = context.watch<CookieBloc>();
    final blocRedirect = context.watch<RedirectBloc>();
    final AllchatsBloc blocall = context.watch<AllchatsBloc>();
   final String cookie = cookieBloc.state is CookieSuccessState ? (cookieBloc.state as CookieSuccessState).cookie :'';
    List<Map<String,dynamic>> data =   bloc.state is LoadArticleProgress? (bloc.state as LoadArticleProgress).stream:[];
    if( bloc.state is LoadingProcessState){
      return Center(child: Container(child: const CircularProgressIndicator(color: Colors.indigo,),width: 20,height: 20,) );
    }
    return Container(child:
   /* bloc.state is LoadArticleProgress ? StreamBuilder<QuerySnapshot>(
      stream: (bloc.state as LoadArticleProgress).stream,//.where('idchat', isEqualTo: '123').orderBy('id',descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final List<Map<String, dynamic>> data = snapshot.data!.docs.map((DocumentSnapshot document) {
        return document.data()! as Map<String, dynamic>;
        }).toList();
         data.sort((a, b) =>int.parse(b['time'].toString())  - int.parse(a['time'].toString()));*/
        //return
        bloc.state is LoadArticleProgress? Container(
        child: Column(
        children: [
        // This is where the chats will go
        Expanded(
        child: Container(
        padding: EdgeInsets.symmetric(
        horizontal: 10
        ),
        child:Stack(children: [
          ListView.builder(
            controller:controller,
            reverse: true,
            itemCount:  (bloc.state as LoadArticleProgress).stream.length,
            itemBuilder: (context, position) {
            //  showedMovieAtIndex(cookie); //потом включитьььь
              //  whatsPixels();
              // return

              return AutoScrollTag(
                key: ValueKey(position),
                controller: controller,
                index: position,
                child: GestureDetector(
                 /* onTap: (){
                    blocRedirect.add(const DeleteRedirectEvent());
                    blocRedirect.add(AddRedirectEvent(redirect:data[position]));
                  },*/
                  onTap:(){
                  //blocRedirect.add(const DeleteRedirectEvent());///////////////////////////////////////////////////////////////////////////////////////////////////////
                    blocRedirect.add(AddRedirectEvent(redirect:data[position]));
                    print(data[position]);
                   buildConfirmDialog(context,data[position]['name']==cookie?data[position]['to'].toString():data[position]['to'].toString(),
                        data[position]['idchat'].toString(),/*blocRedirect.state is YesRedirectState ?(blocRedirect.state as YesRedirectState).redirect : [],*/ blocall, blocRedirect,cookie);///////////////////////////////
                  },
                  onDoubleTap: (){
                    blocRedirect.add(AddRedirectEvent(redirect:data[position]));
                  },
                  child: Row(
                    mainAxisAlignment: data[position]['name'] == cookie ? MainAxisAlignment.end  : MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: data[position]['name'] == cookie  ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: data[position]['new'] == 'yes'  ? Colors.cyan : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                data[position]['redirect']==null ? const SizedBox():
                                (data[position]['redirect'] as List).length > 0?
                                /*    Text(((data[position]['redirect'] as List)[0] as Map<String,dynamic>)['text'])*/
                                GestureDetector(
                                    onTap: (){
                                      Map<String, dynamic> dataEl =  (data[position]['redirect'] as List)[0] as Map<String, dynamic>;
                                      final int id = dataEl['id'];
                                      print(id);
                                      final int index = data.indexWhere((element) => element['id'] == id);
                                      _scrollToCounter(index,'toMessage');
                                    },
                                    child:
                                    Container(
                                      child:
                                      ListView(
                                        children: (data[position]['redirect'] as List).map((dynamic document) {
                                          Map<String, dynamic> datas = document as Map<String, dynamic>;
                                          print('datatatatatat${datas}');
                                          return Text(datas['text']!=null? datas['text']:'');
                                        }).toList(),
                                      ),
                                      width: 100,
                                      height: 50,
                                    )
                                )   :const SizedBox(),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image:  DecorationImage(
                                          image: NetworkImage("${data[position]['image']}"),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          color: Colors.cyan,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      width: 30,
                                      height: 30,
                                    ),
                                    const  SizedBox(width: 10,),
                                    Text(
                                      data[position]['name'].toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                data[position]['images']==null || data[position]['images']=='' ? Text('pusto'):Container(
                    width: 40,
                    height: 40,
                    child:Image.network(data[position]['images'] as String,width: 100,height: 100,)),
                 //   Text('aaaaaa'),
                                Text(
                                  data[position]['text'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Text(GeneralFunction.getTime(data[position]['time']),
                                    style: const TextStyle(color: Colors.black54,fontSize: 10),),
                                ],
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                highlightColor: Colors.black.withOpacity(0.1),
              );
            },
          ),
          isScrollHigher?
              Stack(
                children: [
                      Container(
                        //  padding:const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all( Radius.circular(10)),
                          color: Colors.black12,
                        ),
                        child:
                        IconButton(onPressed:(){
                          _scrollToCounter(0,'down');
                        }, icon:
                        Icon(Icons.arrow_circle_down_outlined,
                          color:  Colors.cyanAccent,size: 25,),)
                        ,),
                 data.where((element) => element['to']==cookie)
                      .where((element) => element['new']=='yes').length!=0 ?
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text( data.where((element) => element['to']==cookie)
                            .where((element) => element['new']=='yes').length.toString(),style: const TextStyle(color: Colors.white),),
                      ):const SizedBox(),
                ],
              )
  :const SizedBox(),
        ],
          alignment: AlignmentDirectional.bottomEnd,
        )

        ),
          ),
          const SizedBox(height: 10,),
          blocRedirect.state is YesRedirectState ?
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal[50]
              ),
              child:
        Column(
        children: [
          Row(children: [
            IconButton(onPressed:(){
              blocRedirect.add(const DeleteRedirectEvent());
            }, icon: const Icon(Icons.close,size: 15,color: Colors.black,))
          ],),
        Text((blocRedirect.state as YesRedirectState).redirect[0]['name'].toString()),
        const SizedBox(height: 5),
        Text((blocRedirect.state as YesRedirectState).redirect[0]['text'].toString()),
        ],
        ),),
            onTap:(){
              final int id = (blocRedirect.state as YesRedirectState).redirect[0]['id'];
              print(id);
              final int index = data.indexWhere((element) => element['id'] == id);
              _scrollToCounter(index,'toMessage');
            },) : const SizedBox(),
          imgBytes==null ?SizedBox():Container(
            width: 40,
            height: 40,
            child: imgBytes!=null ? Image.memory(imgBytes as Uint8List,height: 100,width: 100,):Text('nnn'),
          ) ,
          const SizedBox(height: 10,),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5
            ),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: messageController,
                    //maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter message"
                    ),
                  ),
                ),
                /*ElevatedButton(onPressed: ()async {
                  final String img =  await FirebaseStorage.instance.refFromURL("gs://glot-c5df4.appspot.com/images/me").getDownloadURL().then((value){
                    return value.isNotEmpty? value :'';
                  });
                  print(img);
                }, child: Text("get url")),*/
                IconButton(
                  onPressed: (){
                    _handleAttachmentPressed(context);
                  },
                  icon: Icon(Icons.camera_alt_outlined, color: Theme.of(context).colorScheme.secondary,),
                ),
                IconButton(
                  onPressed: ()async{//слать только с картинками!!!! для просто текстовых сообщений
                    //print(bloc.state);
                  // if(bloc.state !is LoadArticleProgress) return;
                    if(images!=null) {
                      //  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      UploadTask? task = await uploadFile(images);
                      Stream<TaskSnapshot?>? streams = task?.snapshotEvents;
                      StreamSubscription<TaskSnapshot?>? sub;
                      sub = streams?.listen((event) async {
                        if (event?.bytesTransferred == event?.totalBytes && event?.state == TaskState.success) {
                          sub?.cancel();//закрыв подписку,тк то,что ниже будет повторяться ,тк события будут приходить и код будет на них реагировать
                          await geturlfile(images);
                          final time = DateTime
                              .now()
                              .toUtc()
                              .millisecondsSinceEpoch;

                          final mydata = data.where((
                              element) => element['name'] == cookie).toList();
                          int length = 1;
                          int lengthchat = 1;
                          CollectionReference ref = FirebaseFirestore.instance.collection('chats');
                          await ref.where('idchat', isEqualTo:mydata[0]['idchat']).get().then((event)async{
                            if(event.docs.isEmpty){//если нет такого чата
                              await ref.get().then((event) {
                                length =  event.docs.length + length;
                              });
                              await  ref.add({
                                'id':lengthchat,
                                'companion_one': cookie,
                                'idchat':mydata[0]['idchat'],
                                'companion_two': mydata[0]['to'],
                                'timelastmess':time,
                              });
                            }else{
                              for (var doc in event.docs)  {
                                await ref.doc(doc.id.toString())
                                    .update({'timelastmess': time})
                                    .then((value) => print("Chat time Updated"))
                                    .catchError((error) => print("Failed to update user: $error"));
                                print("${doc.id} => ${doc.data()}");
                              }
                            }

                          });
                         /* CollectionReference ref = FirebaseFirestore.instance
                              .collection('chats');
                          await ref.where(
                              'idchat', isEqualTo: mydata[0]['idchat'])
                              .get()
                              .then((event) {
                            for (var doc in event.docs) {
                              ref.doc(doc.id.toString())
                                  .update({'timelastmess': time})
                                  .then((value) => print("Chat time Updated"))
                                  .catchError((error) =>
                                  print("Failed to update user: $error"));
                              // print("${doc.id} => ${doc.data()}");
                            }
                          });*/
                          await FirebaseFirestore.instance.collection(
                              'messages')
                             .get().then((
                              event) {
                            length = event.docs.length + length;
                          });
                          print(length);
                          // final String? urlImage =  await handleUploadType().then((value){ print('rrrrrrrrrrrrrrrrrr${value}rrrrrrrrrrrrrrrrrrrrr');}); //отправ картинку и получ ссылку на нее
                          print('uploaddddddddddddddddd');
                          /*await*/
                          FirebaseFirestore.instance.collection('messages')
                              .add({
                            'id': length,
                            'images': filePath != null ? filePath : '',
                            'image': 'https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d',
                            'name': mydata[0]['name'],
                            'idchat': mydata[0]['idchat'],
                            'to': mydata[0]['to'],
                            'new': 'yes',
                            'time': time,
                            'redirect': blocRedirect.state is YesRedirectState
                                ? (blocRedirect.state as YesRedirectState)
                                .redirect
                                : [],
                            'text': messageController.text.trim().toString()
                          })
                              .then((value) => print("mess Added"))
                              .catchError((error) =>
                              print("Failed to add user: $error"));
                          blocRedirect.add(const DeleteRedirectEvent());

                          // try {
                          await http.post(
                            Uri.parse('https://fcm.googleapis.com/fcm/send'),
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                              'Authorization': 'key=AAAAT80WmFM:APA91bH2td4RPg6FMPSxzJTQWywZyL9LeZkHbR43V0TaAJooHZFR33Fxg165J7kb_W35MkIjI0VWzKLTZmczvksZffYwvSPm5OA0wjpSVg6-f9X3DBaqX75oaQzJ31cXg495q3Jn96rI',
                              //сервер кей из файрбейз
                            },
                            body: jsonEncode(
                              <String, dynamic>{
                                'notification': <String, dynamic>{
                                  'body': messageController.text.trim()
                                      .toString(),
                                  'title': mydata[0]['name'],
                                  // 'actionDate':DateTime.now().add(const Duration(minutes: 2)).toString(),
                                },
                                'priority': 'high',
                                'data': <String, dynamic>{
                                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                  'id': mydata[0]['idchat'],
                                },
                                "to": '/topics/dasha',
                              },
                            ),
                          ).then((value) => print(value.statusCode)).then((
                              value) {
                            setState(() {
                              images = null;
                              imgBytes = null;
                              filePath = null;
                            });
                          });
                          messageController.text = '';
                        }
                      });
                    }else{
                      final time = DateTime
                          .now()
                          .toUtc()
                          .millisecondsSinceEpoch;

                      final mydata = data.where((
                          element) => element['name'] == cookie).toList();
                      int length = 1;
                      int lengthchat = 1;
                      CollectionReference ref = FirebaseFirestore.instance.collection('chats');
                      await ref.where('idchat', isEqualTo:mydata[0]['idchat']).get().then((event)async{
                        if(event.docs.isEmpty){//если нет такого чата
                          await ref.get().then((event) {
                            lengthchat =  event.docs.length + lengthchat;
                          });
                          await  ref.add({
                            'id':lengthchat,
                            'companion_one': cookie,
                            'idchat':mydata[0]['idchat'],
                            'companion_two': mydata[0]['to'],
                            'timelastmess':time,
                          });
                        }else{
                          for (var doc in event.docs)  {
                            await ref.doc(doc.id.toString())
                                .update({'timelastmess': time})
                                .then((value) => print("Chat time Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                            print("${doc.id} => ${doc.data()}");
                          }
                        }

                      });
/////////////////////////////////////////////////////
                   /*   CollectionReference ref = FirebaseFirestore.instance
                          .collection('chats');
                      await ref.where(
                          'idchat', isEqualTo: mydata[0]['idchat'])
                          .get()
                          .then((event) {
                        for (var doc in event.docs) {
                          ref.doc(doc.id.toString())
                              .update({'timelastmess': time})
                              .then((value) => print("Chat time Updated"))
                              .catchError((error) =>
                              print("Failed to update user: $error"));
                          // print("${doc.id} => ${doc.data()}");
                        }
                      });*/
                      await FirebaseFirestore.instance.collection(
                          'messages')
                         .get().then((
                          event) {
                        length = event.docs.length + length;
                      });
                      print(length);
                      // final String? urlImage =  await handleUploadType().then((value){ print('rrrrrrrrrrrrrrrrrr${value}rrrrrrrrrrrrrrrrrrrrr');}); //отправ картинку и получ ссылку на нее
                      print('uploaddddddddddddddddd');
                      /*await*/
                      FirebaseFirestore.instance.collection('messages')
                          .add({
                        'id': length,
                        'images': /*filePath != null ? filePath :*/ '',
                        'image': 'https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d',
                        'name': mydata[0]['name'],
                        'idchat': mydata[0]['idchat'],
                        'to': mydata[0]['to'],
                        'surname': mydata[0]['surname'],
                        'new': 'yes',
                        'time': time,
                        'redirect': blocRedirect.state is YesRedirectState
                            ? (blocRedirect.state as YesRedirectState)
                            .redirect
                            : [],
                        'text': messageController.text.trim().toString()
                      })
                          .then((value) => print("mess Added"))
                          .catchError((error) =>
                          print("Failed to add user: $error"));
                      blocRedirect.add(const DeleteRedirectEvent());

                      // try {
                      await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Authorization': 'key=AAAAT80WmFM:APA91bH2td4RPg6FMPSxzJTQWywZyL9LeZkHbR43V0TaAJooHZFR33Fxg165J7kb_W35MkIjI0VWzKLTZmczvksZffYwvSPm5OA0wjpSVg6-f9X3DBaqX75oaQzJ31cXg495q3Jn96rI',
                          //сервер кей из файрбейз
                        },
                        body: jsonEncode(
                          <String, dynamic>{
                            'notification': <String, dynamic>{
                              'body': messageController.text.trim()
                                  .toString(),
                              'title': mydata[0]['name'],
                              // 'actionDate':DateTime.now().add(const Duration(minutes: 2)).toString(),
                            },
                            'priority': 'high',
                            'data': <String, dynamic>{
                              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                              'id': mydata[0]['idchat'],
                            },
                            "to": '/topics/dasha',
                          },
                        ),
                      ).then((value) => print(value.statusCode)).then((
                          value) {
                        setState(() {
                          images = null;
                          imgBytes = null;
                          filePath = null;
                        });
                      });
                      messageController.text = '';
                    }
                   }, /*catch (e) {
                     print("error push notification");
                   }
                  },*/
                  icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,),
                ),

              ],
            ),
          ),
        ],
          ),
        ):const SizedBox()
   //  },
   // ):const SizedBox()
      );
  }

  Future<UploadTask?> uploadFile(XFile? file) async {
    int length = 1;
    if (file == null) {
      return null;
    }

    UploadTask uploadTask;
    await FirebaseFirestore.instance.collection(
        'messages')
        .where('idchat', isEqualTo: '123').get().then((
        event) {
      length = event.docs.length + length;
    });
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('/${file.name}');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path,'idmess':length.toString()},
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



  Future<void>showedMovieAtIndex(String cookie)async {
    print('SHOWWWWWW');
    //if (index > 1) return;
   if(controller.offset != 0.0) return;
    CollectionReference ref = FirebaseFirestore.instance.collection('messages');
    List<String> data = [];
    await ref.where('name', isEqualTo:'dina').where('to', isEqualTo:cookie).get().then((event) {
      //  data = data + event.docs.toList();
      for (var doc in event.docs)  {
        data.add(doc.id.toString());
        ref
            .doc(doc.id.toString())
            .update({'new': 'no'})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
        print("${doc.id} => ${doc.data()}");
      }
    });
    print('aaa');
  }
}

class ImageBytes extends StatefulWidget {
  final String data;
  const ImageBytes({Key? key,required this.data}) : super(key: key);

  @override
  State<ImageBytes> createState() => _ImageByteState();
}



class _ImageByteState extends State<ImageBytes> {
  final storage = FirebaseStorage.instance;
  String? filePath;

  geturlfile()async{
    await FirebaseStorage.instance.refFromURL("gs://glot-c5df4.appspot.com/images/some-image.jpg").getDownloadURL().then((value){
      setState(() {
        filePath = value;
      });
    });

    print(filePath);
  }


  @override
  initState(){
    geturlfile();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child:filePath!=null? Image.network(filePath.toString(),width: 100,height: 100,):SizedBox()
      ),
  /*    ElevatedButton(child: Text('upload'),onPressed:
      geturlfile,),*/
    ],);
  }
}


void buildConfirmDialog(BuildContext context, String to, String idchat,AllchatsBloc blocall, RedirectBloc blocRedirect,String cookie) {//мод окно для редиректа
//в полигл делать не чаты, а списки людей..и провер,есть ли с ними чаты, если нет,то создать чат
  showDialog(
      context: context,
      builder: (context) {
        return
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0))),
                  child:
                  Container(
                      padding:const EdgeInsets.all(15),
                      child: Column(children:[
                     /*   TextField(
                          onChanged:(text){text.isEmpty? blocall.add(const ShowSearchEvent(search:'',userName: 'dasha')):blocall.add(ShowSearchEvent(search:text,userName: 'dasha'));
                          print(text.isEmpty);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            labelText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            /* suffixIcon: GestureDetector(
                      onTap: (){
                      blocall.add(const ShowSearchEvent(search: '',userName: 'dasha'));},
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),*/
                          ),
                        ),*/
                        const SizedBox(height: 10,),
                        blocall.state is LoadAllArticleProgress ?  Expanded(child:ListView.builder(//только те,с кем есть чаты
                            itemCount: (blocall.state as LoadAllArticleProgress).list.length,
                            itemBuilder: (context, position) {
                              //  showedMovieAtIndex();
                              //  whatsPixels();
                              final List<Map<String,dynamic>> messThisChat =
                              (blocall.state as LoadAllArticleProgress).listmess.where((element) => element['idchat']==(blocall.state as LoadAllArticleProgress).list[position]['idchat']).toList();
                              messThisChat.sort((a, b) =>
                              int.parse(b['time'].toString()) -
                                  int.parse(a['time'].toString()));

                              final List <Map<String,dynamic>> myNewMes = messThisChat
                                  .where((element) => element['to']==cookie)
                                  .where((el)=>el['new']=='yes').toList();
                              //время
                              return messThisChat.isNotEmpty? GestureDetector(
                                onTap: () {
                                  print((blocall.state as LoadAllArticleProgress).list[position]['idchat']);
                                  final Map<String,String> arguments = {'idchat':(blocall.state as LoadAllArticleProgress).list[position]['idchat'],'name':(blocall.state as LoadAllArticleProgress).list[position]['companion_one'] == 'dariavladimirowna@gmail.com'?
                                  (blocall.state as LoadAllArticleProgress).list[position]['companion_two'] : (blocall.state as LoadAllArticleProgress).list[position]['companion_one']};
                                  print(arguments);
                                  Navigator.pushNamed(context, '/messages',arguments:arguments);
                                },
                                child:Column(children:[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          image:  DecorationImage(
                                            image: NetworkImage("${messThisChat[0]['image']}"),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(context).colorScheme.secondary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(35),
                                        ),
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 20,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          (blocall.state as LoadAllArticleProgress).list[position]['companion_one'] !=
                                              (blocall.state as LoadAllArticleProgress).list[position]['companion_two'] ? Text(
                                            (blocall.state as LoadAllArticleProgress).list[position]['companion_one'] == cookie
                                                ?
                                            (blocall.state as LoadAllArticleProgress).list[position]['companion_two']
                                                : (blocall.state as LoadAllArticleProgress).list[position]['companion_one'],style: const TextStyle(color: Colors.black54),)
                                              : const Text('избранное'),
                                          const SizedBox(height: 25,),

                                        ],
                                      ),
                                      const  Expanded(child: SizedBox()),
                                    ElevatedButton(onPressed:()async{
                                      print((blocRedirect.state as YesRedirectState).redirect);
                                        final time = DateTime.now().toUtc().millisecondsSinceEpoch;
                                        int length = 1;
                                        int lengthchat = 1;
                                        CollectionReference ref = FirebaseFirestore.instance.collection('chats');
                                        await ref.where('idchat', isEqualTo:idchat).get().then((event)async{
                                          if(event.docs.isEmpty){//если нет такого чата
                                       await ref.get().then((event) {
                                              length =  event.docs.length + length;
                                            });
                                          await  ref.add({
                                              'id':length,
                                              'companion_one': cookie,
                                              'idchat': idchat,
                                              'companion_two': to,
                                              'timelastmess':time,
                                            });
                                          }else{
                                            for (var doc in event.docs)  {
                                             await ref.doc(doc.id.toString())
                                                  .update({'timelastmess': time})
                                                  .then((value) => print("Chat time Updated"))
                                                  .catchError((error) => print("Failed to update user: $error"));
                                              print("${doc.id} => ${doc.data()}");
                                            }
                                          }

                                        });
                                        await FirebaseFirestore.instance.collection('messages')
                                            .get().then((event) {
                                          length =  event.docs.length + length;
                                        });
                                        print(length);

                                        await FirebaseFirestore.instance.collection('messages')
                                            .add({
                                          'id':length,
                                          'image':'https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d',
                                          'name': cookie,
                                          'idchat': idchat,
                                          'to': to,
                                          'surname':'',
                                          'new':'yes',
                                          'time':time,
                                          'redirect':blocRedirect.state is YesRedirectState ? (blocRedirect.state as YesRedirectState).redirect:[],
                                          'text':''
                                        })
                                            .then((value) => print("mess Added"))
                                            .catchError((error) => print("Failed to add user: $error"));

                                        // try {
                                        await  http.post(
                                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                          headers: <String, String>{
                                            'Content-Type': 'application/json',
                                            'Authorization': 'key=AAAAT80WmFM:APA91bH2td4RPg6FMPSxzJTQWywZyL9LeZkHbR43V0TaAJooHZFR33Fxg165J7kb_W35MkIjI0VWzKLTZmczvksZffYwvSPm5OA0wjpSVg6-f9X3DBaqX75oaQzJ31cXg495q3Jn96rI',//сервер кей из файрбейз
                                          },
                                          body: jsonEncode(
                                            <String, dynamic>{
                                              'notification': <String, dynamic>{
                                                'body': '',
                                                'title': cookie,
                                                // 'actionDate':DateTime.now().add(const Duration(minutes: 2)).toString(),
                                              },
                                              'priority': 'high',
                                              'data': <String, dynamic>{
                                                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                                'id': idchat,
                                              },
                                              "to": '/topics/dasha',
                                            },
                                          ),
                                        ).then((value) => print(value.statusCode));
                                        blocRedirect.add(const DeleteRedirectEvent());
                                        Navigator.pop(context);
                                      }, child: Text('send'))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                    const Expanded(child: const Divider(color: Colors.black54,height: 2,))
                                  ],
                                  ),

                                ],
                                ),
                              ):const SizedBox();

                            }
                        )
                        ):const SizedBox()
                      ]
                      )

                  )
              ));
      });
}




/*class _UserInformationState extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['surname']),
            );
          }).toList(),
        );
      },
    );
  }
}*/


/*class Sreams extends StatefulWidget {
  const Sreams({Key? key}) : super(key: key);

  @override
  State<Sreams> createState() => _SreamsState();
}

class _SreamsState extends State<Sreams> {

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('messages')
      .where('idchat',isEqualTo: '123')
      .snapshots();
  late AutoScrollController controller;
  final scrollDirection = Axis.vertical;

  Future _scrollToCounter() async {
    await controller.scrollToIndex(1,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(1);
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
/*viewportBoundaryGetter: () =>
Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
axis: scrollDirection*/);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final List<Map<String, dynamic» data = snapshot.data!.docs.map((DocumentSnapshot document) {
        return document.data()! as Map<String, dynamic>;
        }).toList();
        return ListView.builder(
        itemCount: data.length,
        controller:controller ,
        itemBuilder: (context, position) {
        showedMovieAtIndex(position,data.length,data[position]['idchat']);
        return
        AutoScrollTag(
        key: ValueKey(position),
        controller: controller,
        index: position,
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 90),
        child: GestureDetector(
        child: Text(data[position]['id'].toString()),
        onTap: (){
        print('aa');
        _scrollToCounter();
        },
        )
        ),
        highlightColor: Colors.black.withOpacity(0.1),
        );

        },
        );
      },
    );
  }
}*/
//import 'package:scroll_to_index/scroll_to_index.dart';




Future<void>getName()async{
  print('begin');
  final ref = FirebaseFirestore.instance;
  var data = [];
  await ref.collection('messages').where('name', isEqualTo:'dasha').where('to', isEqualTo:'dina').get().then((event) {
   data = data + event.docs.toList();
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
  await ref.collection('messages').where('name', isEqualTo:'dina').where('to', isEqualTo:'dasha').get().then((event) {
    for (var doc in event.docs) {
      data = data + event.docs.toList();
      print("${doc.id} => ${doc.data()}");
    }
  });
  /*final moviesRef = FirebaseFirestore.instance
      .collection('firestore-example-app')
      .withConverter<Movie>(
    fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
    toFirestore: (movie, _) => movie.toJson(),
  );*/
 // final ref = FirebaseDatabase.instance.ref('/messages');
 //final snapshot = await ref.child('/messages/qSOjdHQfgSYhTiTeO1t6').get();
  print('prr${ref}');
  /*if (snapshot.exists) {
    print(snapshot.value);
  } else {
    print('No data available.');
  }*/
}

/*class Sreams extends StatelessWidget {
  Sreams({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('messages')
      .where('idchat',isEqualTo: '123')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final List<Map<String, dynamic» data = snapshot.data!.docs.map((DocumentSnapshot document) {
        return document.data()! as Map<String, dynamic>;
        }).toList();
        return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, position) {
        showedMovieAtIndex(position,data.length,data[position]['idchat']);
        return Container(
        padding: EdgeInsets.symmetric(vertical: 90),
        child: Text(data[position]['name']),
        );
        },
        );
      },
    );
  }
}
void showedMovieAtIndex(int index, int length,String idchat) {
  if (index < length - 1) return;
  print('ppii');
  final f = FirebaseFirestore.instance.collection('messages')
      .where('idchat',isEqualTo: '123').snapshots().map((event) => event.docs.map((e){
    final d = e.data()! as Map<String, dynamic>;
    print('${d['name'].toString()}oo');
    print(e.data()! as Map<String, dynamic>);
    return e.data()! as Map<String, dynamic>;
  }
  )
  );

}*/
