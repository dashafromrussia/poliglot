import 'package:flutter/material.dart';
import 'package:poliglot/core/cookie_bloc.dart';
import 'package:poliglot/core/drawerBloc.dart';
import 'package:poliglot/core/MyDataBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/core/newMessBloc.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_article/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_book/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_main/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_update/presentation/pages/MainWidgets.dart';
import 'package:poliglot/future_chats/presentation/pages/MainWidgets.dart';


/*class DrawerWidget extends StatefulWidget {

 late  Widget widgetNow;

  DrawerWidget({
    Key? key,
  }) : super(key: key);


  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}
*/

class DrawerWidget extends StatelessWidget  /*State<DrawerWidget>*/ {

 /* late Widget widgetNow;
  DrawerWidget getWidget (widget){
    widgetNow = widget;
    return this;
  }*/

/*(bloc.state as MyDataSuccessState).user.image.isNotEmpty ?
   (bloc.state as MyDataSuccessState).user.image
    :*/
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MyDataBloc>();
    print('drawer');
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
            Container(
            margin:  const EdgeInsets.only(bottom: 40),
            padding:const EdgeInsets.symmetric(vertical: 60) ,
            color: Theme.of(context).primaryColor,
            child: Center( child:
            bloc.state is MyDataSuccessState ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
             children:[
               Container(
                 decoration: BoxDecoration(
                   color: const Color(0xff7c94b6),
                   image:  DecorationImage(
                     image: NetworkImage("${(bloc.state as MyDataSuccessState).user.image}"),
                     fit: BoxFit.cover,
                   ),
                   border: Border.all(
                     color: Colors.cyan,
                     width: 5,
                   ),
                   borderRadius: BorderRadius.circular(35),
                 ),
               width: 70,
               height: 70,
               ),
              const SizedBox(height: 20),
               Text((bloc.state as MyDataSuccessState).user.name,
                   style:const TextStyle(color: Colors.white,fontSize: 17) ),
               const SizedBox(height: 11),
               Text("Страна: ${(bloc.state as MyDataSuccessState).user.country}",
                   style:const TextStyle(color: Colors.white,fontSize: 15) ),
               const SizedBox(height: 11),
               Text("Возраст: ${(bloc.state as MyDataSuccessState).user.age}",
                   style:const TextStyle(color: Colors.white,fontSize: 15) ),
             ],
            ),
                const SizedBox(width: 50,),
                 IconButton(icon:Icon(Icons.edit_note,color:Colors.white,size: 40,),
                  tooltip: 'Edit',
                  onPressed:(){
                   User userData = (bloc.state as MyDataSuccessState).user;
                    Navigator.pushNamed(context, '/update',arguments: userData);
                  },
                  )
              ],
            ):const SizedBox(),
    ),
          ),
          DataWidget( select: 'Books', navigate: '/books', name:'Мои учебники',icon: Icons.book_outlined,),
          DataWidget( select: 'Articles', navigate: '/articles',name:'Статьи',icon: Icons.article_rounded,),
          DataWidget( select: 'Main', navigate: '/main', name:'Главная', icon:Icons.star),
          DataWidget( select: 'Chats', navigate: '/chats', name:'Мои чаты', icon:Icons.chat_outlined),
          DataWidget( select: 'Users', navigate: '/users', name:'Пользователи', icon:Icons.accessibility_new_outlined),
         // DataWidget( select: 'Update', navigate: '/update', name:'Обновить данные',icon:Icons.arrow_back_ios_new),
          DataWidget( select: 'Exit', navigate: '/', name:'Выход',icon:Icons.exit_to_app),
        ],
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final IconData icon;
  final String select;
  final String navigate;
  final String name;
   DataWidget({Key? key, required this.select,required this.icon,
    required this.name, required this.navigate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DrawerBloc>();
    final blocCookie = context.read<CookieDrawerBloc>();
    final blocNewMess = context.watch<NewMessBloc>();
    final newMess = blocNewMess.state is NewMessProgress? (blocNewMess.state as NewMessProgress).newmess.toString():'';
    return StreamBuilder<DrawerState>(
      initialData:bloc.state,
      stream: bloc.stream,
      builder: (context, snapshot) {
        return
          ListTile(
             leading:Icon(icon,color:(snapshot.requireData as ToggleState).selects[select]),
              title: select=='chats' && newMess!=''? Text('${name} + ',style: TextStyle(color:(snapshot.requireData as ToggleState).selects[select]))
              :Text(name,style: TextStyle(color:(snapshot.requireData as ToggleState).selects[select])),
              onTap: () {
            //  bloc.add(ToggleDrawer(select));
              Navigator.pop(context);
              if(select=='Exit'){
              bloc.add(ExitEvent());
              blocCookie.add(ExitCookieEvent());
              }
          //if(widgetNow is! BookDataWidget) {
                Navigator.pushNamed(context, navigate);
           //  }
            },

          );
      },
    )
    ;
  }
  /*final  Map<String,Color> selects = {'Books': Colors.black,'Main': Colors.black, 'Articles':Colors.black, 'Update': Colors.black,
  'Chats': Colors.black, 'Exit':Colors.black};

String whatColor(Widget widgetNow){
    if(widgetNow is MainDataWidget){
      return 'Main';
    }else if(widgetNow is BookDataWidget){
      return 'Books';
    }else if(widgetNow is ArticlesDataWidget){
      return 'Articles';
    }else if(widgetNow is ChatsDataWidget){
      return 'Chats';
    }else if(widgetNow is UpdateDataWidget){
      return 'Update';
    }

      return 'Exit';
}*/

}

//(snapshot.requireData as ToggleState).selects[select]