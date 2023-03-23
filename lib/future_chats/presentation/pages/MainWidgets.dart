/*import 'package:flutter/material.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/navigation/MainNavigation.dart';


class ChatsDataWidget extends StatelessWidget {
  final Widget drawerWidget;
  const ChatsDataWidget({Key? key, required this.drawerWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
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
      drawer: drawerWidget
    );
  }
}


class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      final bloc = context.read<ChatsBloc>();
      return StreamBuilder<ChatsState>(
        initialData:bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Text("${(snapshot.requireData as ChatsCount).count}age.count.");
        },
      )
      ;
    }
  }

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatsBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(SendData()),
      child: const Text('BOOk'),
    );
  }
}*/


