import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/feature_allusers/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_allusers/presentation/bloc/search_userbloc.dart';
import 'package:poliglot/feature_allusers/presentation/bloc/chats_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
import 'package:poliglot/entities/user.data.dart';
import 'dart:math';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';

class UsersDataWidget extends StatefulWidget{
  final Widget drawerWidget;
  const UsersDataWidget({Key? key, required this.drawerWidget}) : super(key: key);
  @override
  UsersDataWidgetState createState() => UsersDataWidgetState();

}

class UsersDataWidgetState extends State<UsersDataWidget>{
  late ArticlesBloc bloc = context.watch<ArticlesBloc>();
  UsersDataWidgetState();

  @override
  void initState(){
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cookieBloc = context.watch<CookieBloc>();
    final String cookie = cookieBloc.state is CookieSuccessState ? (cookieBloc.state as CookieSuccessState).cookie :'';
    final bloc = context.watch<AllUserBloc>();
    final search = context.watch<SearchUsersBloc>();
    //  print(bloc.state is ArticlesCategoryState ? (bloc.state as ArticlesCategoryState).articles:[]);
     List<User> users = bloc.state is FinishDataState ? (bloc.state as FinishDataState).allusers :
     bloc.state is SearchDataState ?(bloc.state as FinishDataState).allusers:
     [];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login to your account',style: TextStyle(fontFamily:'IndieFlower'),),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: (){
                search.add(const ShowSearchHolderEvent());
                print(search.state);
              }
              ,
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child:Column(
              children:[
                search.state is BeginSearchState ? Container(
                    padding: const EdgeInsets.all(10),
                    child:TextField(
                      onChanged:(text){text.isEmpty? bloc.add(const SearchUserEvent(search:'')):bloc.add( SearchUserEvent(search:text));
                      print(text.isEmpty);},
                      decoration: InputDecoration(
                        border:const OutlineInputBorder(),
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: (){search.add(const ShowUnSearchHolderEvent());
                         // bloc.add(const SearchUserEvent(search: ''));
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                ):const SizedBox(),
                bloc.state is ArticlesCategoryState?  Expanded(
                  // height:MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 40),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: users.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: (){

                            },
                            child:
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding:const EdgeInsets.all(100),
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        image:  DecorationImage(
                                          image: NetworkImage("${users[index].image}"),
                                          fit: BoxFit.cover,
                                        ),
                                        /*border: Border.all(
                              //color: Colors.cyan,
                             // width: 5,
                            ),*/
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: 120,
                                    ),
                                    Positioned(
                                      left:50,
                                      bottom:0,
                                      child:
                                      Container(
                                        child: Text("${users[index].name}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                        color: Colors.indigo,
                                          borderRadius: BorderRadius.circular(9),
                                        ),
                                      ),),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                      margin:const EdgeInsets.only(top:10),
                                      child: Text("+ Add",style: GoogleFonts.openSans(fontSize: 17),)
                                  ),
                                ),
                                Container(
                                    margin:const EdgeInsets.only(top:10),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            child:Text("age:${users[index].age}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ),)
                                        ),
                                        Container(
                                            child: Text("country:${users[index].country}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ))
                                        ),
                                      ],
                                    )),
                              SizedBox(height: 10,),
                              ElevatedButton(onPressed:(){
                                cookie;
                                final blocIdchat = context.watch<ChatsBloc>();
                                blocIdchat.add(IsChatsEvent(my: cookie,to:users[index].name,context: context));
                              }, child: Text("Написать"))
                              ],
                            )
                        );
                      },
                    )):const SizedBox(width: 20,),
              ],
            ),
          ),
        ),
        drawer: widget.drawerWidget
    );
  }
}








