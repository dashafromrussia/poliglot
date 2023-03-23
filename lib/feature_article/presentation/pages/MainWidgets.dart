import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/bloc/search_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/navigation/MainNavigation.dart';



class ArticlesDataWidget extends StatefulWidget{
final Widget drawerWidget;
  const ArticlesDataWidget({Key? key, required this.drawerWidget}) : super(key: key);
  @override
  ArticlesDataWidgetState createState() => ArticlesDataWidgetState();

}

  class ArticlesDataWidgetState extends State<ArticlesDataWidget>{
    late ArticlesBloc bloc = context.watch<ArticlesBloc>();
    ArticlesDataWidgetState();

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
   final bloc = context.watch<ArticlesBloc>();
   final search = context.watch<SearchBloc>();
  //  print(bloc.state is ArticlesCategoryState ? (bloc.state as ArticlesCategoryState).articles:[]);
  final List<Articles> articles = bloc.state is ArticlesCategoryState ? bloc.state is ArticlesOtherState ? (bloc.state as ArticlesOtherState).articles:
  bloc.state is ArticlesInterestState ? (bloc.state as ArticlesInterestState).articles:
  bloc.state is ArticlesLifehackState ? (bloc.state as ArticlesLifehackState).articles:
  bloc.state is ArticlesCalendarState ? (bloc.state as ArticlesCalendarState).articles:
  bloc.state is ArticlesSearchState? (bloc.state as ArticlesSearchState).articles:
  bloc.state is ArticlesSearchEmptyState ? (bloc.state as ArticlesSearchEmptyState).articles:
  bloc.state is ArticlesAllState ? (bloc.state as ArticlesAllState).articles:[]:[];
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
  Container(
    margin:const EdgeInsets.only(top:10),
    child:
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const _ButtonWidget(color: Colors.deepOrange, category: 'interest', name: 'Интересное'),
      const _ButtonWidget(color: Colors.pink, category: 'other', name: 'Другое'),
      const _ButtonWidget(color: Colors.green, category: 'calendar', name: 'Полезное'),
    ],
  ),
    ),
 Container(
   margin:const EdgeInsets.only(top:5),
   child:
 Row(
   mainAxisAlignment: MainAxisAlignment.center,
   crossAxisAlignment: CrossAxisAlignment.center,
   children: [
     const _ButtonWidget(color: Colors.deepPurple, category: 'lifehack', name: 'Лайфхаки'),
     const SizedBox(width: 30,),
     const _ButtonWidget(color: Colors.blue, category: 'all', name: 'Все статьи'),
   ],
 ),
   ),
    search.state is BeginSearchState ? Container(
      padding: const EdgeInsets.all(10),
    child:TextField(
      onChanged:(text){text.isEmpty? bloc.add(const ShowSearchEvent(search:'')):bloc.add( ShowSearchEvent(search:text));
                       print(text.isEmpty);},
        decoration: InputDecoration(
          border:const OutlineInputBorder(),
          labelText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            onTap: (){search.add(const ShowUnSearchHolderEvent());
              bloc.add(const ShowSearchEvent(search: ''));},
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
  itemCount: articles.length,
  shrinkWrap: true,
  itemBuilder: (BuildContext context, int index) {
  return GestureDetector(
  onTap: (){
  Navigator.pushReplacementNamed(context,'/articles/one',arguments:articles[index]);
  if(!bloc.isClosed){
  bloc.add(AddViewEvent(articles[index].id));
  }
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
  image: NetworkImage("${articles[index].image}"),
  fit: BoxFit.cover,
  ),
  /*border: Border.all(
                              //color: Colors.cyan,
                             // width: 5,
                            ),*/
  borderRadius: BorderRadius.circular(30),
  ),
  width: MediaQuery.of(context).size.width*0.9,
  height: 120,
  ),
  Positioned(
  left:50,
  bottom:0,
  child:
  Container(
  child: Text("${articles[index].category}",
  style: TextStyle(color: Colors.white),
  ),
  padding:const EdgeInsets.all(5),
  decoration: BoxDecoration(
  color:articles[index].category=='interest' ?
  Colors.deepOrange:articles[index].category=='other'?
  Colors.pink:articles[index].category=='lifehack'?
  Colors.deepPurple:articles[index].category=='calendar'?
  Colors.green: Colors.blue,
  /*border: Border.all(
                              //color: Colors.cyan,
                             // width: 5,
                            ),*/
  borderRadius: BorderRadius.circular(9),
  ),
  ),),
  ],
  ),
  Container(
  margin:const EdgeInsets.only(top:10),
  child: Text("${articles[index].header}",style: GoogleFonts.openSans(fontSize: 17),)
  ),
  Container(
  margin:const EdgeInsets.only(top:10),
  child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  Container(
  child:Text("views:${articles[index].views}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ),)
  ),
    Container(
        child: Text("${articles[index].time}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ))
    ),
  Container(
  child:Text("likes:${articles[index].likes.length}",style:GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ))
  ),
  ],
  ))
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




class _ButtonWidget extends StatelessWidget {
  final MaterialColor color;
  final String category;
  final String name;
  const _ButtonWidget({Key? key,required this.color,required this.category,required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ArticlesBloc>();

    return ElevatedButton(
      onPressed: ()=> bloc.add(ShowCategoryEvent(category: category)),
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
      child: Text(name),
    );
  }
}


/*class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ArticlesBloc>();
    return StreamBuilder<AppState>(
      initialData:bloc.state,
      stream: bloc.stream,
      builder: (context, snapshot) {
        return Text("${(snapshot.requireData as AppCount).count}age App.count.");
      },
    )
    ;
  }
}*/


/*class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      final bloc = context.read<ArticlesBloc>();
      return StreamBuilder<ArticlesBloc>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Text("${(snapshot.requireData as MainCount).count}age.count.");
        },
      )
      ;
    }
  }*/

/*class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(SendData()),
      child: const Text('ИГЕЕЩТ'),
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
