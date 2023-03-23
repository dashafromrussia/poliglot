import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
import 'dart:convert';

class MainDataWidget extends StatelessWidget {
 final Widget drawerWidget;
 const MainDataWidget({Key? key,required this.drawerWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    return BlocListener<AppBloc,AppState>(
        listener: (
            BuildContext context,
            AppState state,
            ) {
          print((state as ToggleState).selects['Main']);
          if((state is ToggleState)){
            print((state as ToggleState).selects['Main']);
            appBloc.add(const ToggleDrawer('Main'));
          }
        },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
          actions: [
          /*  IconButton(
              icon: const Icon(Icons.exit_to_app),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            )*/
          ]
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            //   mainAxisSize: MainAxisSize.min,
            children: const [
               MainWidget(),
              //  ButtonWidget()
             // Text('main')
            ],
          ),
        ),
      ),
      drawer: drawerWidget,
    ),
    );
  }
}

void _onListen(
    BuildContext context,
    AppState state,
    ) {
  if((state as ToggleState).selects['Main']==Colors.black){

  }
}

//Text("${(snapshot.requireData as MainCount).count}age.count.")

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return StreamBuilder<MainState>(
      initialData: bloc.state,
      stream: bloc.stream,
      builder: (context, snapshot) {
        return Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset("images/world.png"),width: 500,height: 400,),
            Container(
              width: 400,
              height: 500,
              child:Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Учи языки вместе с нашей командой Poliglot!',style: TextStyle(color: Colors.indigo,fontSize: 47)),
                  const SizedBox(height: 50),
                  ElevatedButton(onPressed: ()async{
                    final clients = HttpClient();
                    final request = await clients.postUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
                    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
                    final response = await request.close();
                    print(response);
                    response.transform(utf8.decoder).listen((contents) {
                      print(contents);
                    });
                   // Navigator.pushNamed(context, '/books');
                  }, child:const Text('Дерзай!',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo))
                ],
              )
              ,)
            ),

          ],)
        );
      },
    )
    ;
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(SendData()),
      child: const Text('BOOk'),
    );
  }
}