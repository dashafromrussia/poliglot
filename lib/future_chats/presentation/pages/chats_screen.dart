import 'dart:async';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/allchat_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_event.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_user_bloc.dart';
import 'package:poliglot/generalFunction.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:poliglot/future_chats/presentation/bloc/redirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poliglot/future_chats/presentation/bloc/chats_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:widget_size/widget_size.dart';
import 'package:widget_finder/widget_finder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
//import 'package:smsker/smsker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

//поиск по чатам
//cдел зависимым от блока с личной инфой,чтобы можно было тянуть фото и проч

class ChatsInfoState extends StatelessWidget {
  final Widget drawerWidget;
  const ChatsInfoState({super.key,required this.drawerWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Чаты'),
        actions: [

        ],
      ),
      body: SafeArea(
        child: ChatsInfo(),
      ),
        drawer: drawerWidget
    );
  }
}



class ChatsInfo extends StatelessWidget {


  Widget build(BuildContext context) {
    final blocall = context.watch<AllchatsBloc>();
    final bloc = context.watch<ChatsBloc>();
    final blocStatus = context.watch<StatusBloc>();
    final cookieBloc = context.watch<CookieBloc>();
    final String cookie = cookieBloc.state is CookieSuccessState ? (cookieBloc.state as CookieSuccessState).cookie :'';
    return
          Container(
            padding:const EdgeInsets.all(15),
              child: Column(children:[
                TextField(
                  onChanged:(text){text.isEmpty? blocall.add(ShowSearchEvent(search:'',userName: cookie)):blocall.add(ShowSearchEvent(search:text,userName:cookie));
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
                ),
                const SizedBox(height: 10,),
                blocall.state is LoadAllArticleProgress ?   Expanded(child:ListView.builder(
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
                                Text(messThisChat.isNotEmpty? messThisChat[0]['text']:'',style: const TextStyle(color: Colors.black54)),
                                Text(myNewMes.isNotEmpty ? 'новые сообщения:${myNewMes.length.toString()}':'')
                              ],
                            ),
                             const  Expanded(child: SizedBox()),
                              Text(GeneralFunction.getTime((blocall.state as LoadAllArticleProgress).list[position]['timelastmess']),style: const TextStyle(color: Colors.black54),),
                              ],
                            ),
                             Row(children: [
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

          );

  }

}

String getTime(int time){
  String resultime ='';
  final int dateMess = time is int ? time : 0;
  final today = DateTime.now().toUtc().millisecondsSinceEpoch;
  final tomorrow = DateTime.now().toUtc().add(const Duration(hours: 24)).millisecondsSinceEpoch;
  final oneDayMilliSeconds = tomorrow - today;
  final differenceDay = today - dateMess;
  if(differenceDay < oneDayMilliSeconds){
    resultime = '${(DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).minute}';
  }else if(differenceDay > oneDayMilliSeconds){
    resultime = '${(DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).minute}';
  }
  return resultime;
}










