import 'package:flutter/material.dart';

import 'package:poliglot/entities/userLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/feature_pass/presentation/bloc/main_bloc.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class _AuthDataStorage {
  String email = "";
}


class PasswordDataWidget extends StatelessWidget {
  const PasswordDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _AuthDataStorage(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Poliglot'),
        ),
        body: ListView(
          children: [
            _HeaderWidget(),
          ],
        ),
      ),
    );
  }
}


class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
           _FormWidget(),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
   _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
      fillColor: Colors.red,
      focusColor: Colors.red,
      hoverColor: Colors.red,
    );
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       const _ErrorMessageWidget(),
        const Text(
          'Email',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          maxLength: 50,
          decoration: textFieldDecorator,
          onChanged: (text){ authDataStorage.email = text;
            print(authDataStorage.email);},
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 25),
         const  Center(child:const _AuthButtonWidget()),
          //  const SizedBox(width: 30),
      const SizedBox(height: 30,),
       const _SuccessMessageWidget()
      ],
    ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PassBloc>();
    final authDataStorage = context.read<_AuthDataStorage>();
    const color = Colors.blue;
    final canStartAuth = bloc.state is ForgetPassState ||
        bloc.state is ErrorPassState;
    final onPressed = canStartAuth
        ? ()=> bloc.add(GetMyPassEvent(authDataStorage.email.trim())): null;
    final child = bloc.state is ProcessSendpassState
        ? const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : const Text('Отправить пароль');
    return ElevatedButton(
      onPressed: onPressed,
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
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((PassBloc c) {
      final state = c.state;
      return state is ErrorPassState ? state.error: null;
    });
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}

class _SuccessMessageWidget extends StatelessWidget {
  const _SuccessMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((PassBloc c) {
      final state = c.state;
      return state is PasswordSend ? 'Пароль успешно выслан Вам на электронный адрес!': null;
    });
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.green,
        ),
      ),
    );
  }
}


