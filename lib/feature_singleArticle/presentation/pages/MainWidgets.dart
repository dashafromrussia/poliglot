import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';
//import 'package:poliglot/feature_singleArticle/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/main_bloc.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
//import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';

class OneArticleDataWidget extends StatelessWidget {
final int id;
  const OneArticleDataWidget({Key? key,required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final artbloc = context.watch<ArticlesBloc>();
    final bloc = context.watch<OneArticlesBloc>();
    final cookieBloc = context.watch<CookieBloc>();
    return Scaffold(
        appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context,'/articles');
    },
          child: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
          title: const Text('Login to your account'),
        ),
        body: SafeArea(
          child: Center(
         child: bloc.state is ArticlesFinishData?
                    Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding:const EdgeInsets.all(100),
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image:  DecorationImage(
                              image: NetworkImage("${(bloc.state as ArticlesFinishData).article.image}"),
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
                       child: Text("${(bloc.state as ArticlesFinishData).article.category}",
                         style: TextStyle(color: Colors.white),
                       ),
                       padding:const EdgeInsets.all(5),
                       decoration: BoxDecoration(
                         color: Colors.blue,
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
                        margin:const EdgeInsets.only(top:20),
                      child: Text("${(bloc.state as ArticlesFinishData).article.header}",style: GoogleFonts.openSans(fontSize: 17))
                    ),
                    Container(
                        margin:const EdgeInsets.only(top:20),
                        child: Text("${(bloc.state as ArticlesFinishData).article.twoheader}",style: GoogleFonts.openSans(fontSize: 15, ))
                    ),
                    Container(
                      margin:const EdgeInsets.only(top:15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Container(
                        child:Text("views: ${(bloc.state as ArticlesFinishData).article.views}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ))
                      ),
                        Container(
                           // margin:const EdgeInsets.only(top:15),
                            child: Text("${(bloc.state as ArticlesFinishData).article.time}",style: GoogleFonts.openSans(fontSize: 15,color:Colors.black12 ))
                        ),
                        Container(
                            child: Stack(
                                children: [
                                  IconButton(onPressed:(){
                                    bloc.add(GiveLikesEvent((cookieBloc.state as CookieSuccessState).cookie));
                                  }, icon:(bloc.state as ArticlesFinishData).article.likes
                                       .where((element) =>
                             element==(cookieBloc.state as CookieSuccessState).cookie).toList().length!=0 ?
                                 const Icon(Icons.heart_broken_outlined,color: Colors.red):
                                  const Icon(Icons.heart_broken_outlined, color:Colors.black)),
                               Positioned(
                               right:0,
                                 bottom:4,
                                 child:Text("${(bloc.state as ArticlesFinishData).article.likes.length}",style: GoogleFonts.openSans(fontSize: 10,color:Colors.black54))
                               ),
                                     ],
                                   )
                        ),
                      ],
                    )
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child:
                    Center(child:
                    Text("${(bloc.state as ArticlesFinishData).article.text}",
                        style: GoogleFonts.openSans(fontSize: 15,color:Colors.black54)) ,)
                      ,),
                  ],

                    )
             :
         const SizedBox(),
          ),
        ),
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
