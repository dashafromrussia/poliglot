import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_article/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/navigation/MainNavigation.dart';


class BookDataWidget extends StatelessWidget {
  final Widget drawerWidget;
  const BookDataWidget({Key? key, required this.drawerWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   /* final blocApp = context.watch<AppBloc>();
    blocApp.add(const ToggleDrawer('Books'));*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
         //   mainAxisSize: MainAxisSize.min,
            children: const [
            MainWidget(),
            ButtonWidget(),
              Text('book'),
            //  AppWidget(),
           //   ButtonAppWidget()
            ],
          ),
        ),
      ),
      drawer: drawerWidget
    );
  }
}


class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      final bloc = context.read<BookBloc>();
      return StreamBuilder<BookState>(
        initialData:bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Text("${(snapshot.requireData as BookCount).count}age.count.", style: GoogleFonts.openSans(fontSize: 20));
        },
      )
      ;
    }
  }

/*class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppBloc>();
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

/*class ButtonAppWidget extends StatelessWidget {
  const ButtonAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(AppData()),
      child: const Text('Appp'),
    );
  }
}*/

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(SendData()),
      child: const Text('BOOk'),
    );
  }
}


