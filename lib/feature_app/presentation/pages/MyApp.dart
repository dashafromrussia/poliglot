import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_event.dart';
import 'package:poliglot/main.dart';
import 'package:poliglot/navigation/MainNavigationRouteNames.dart';
import 'package:bloc/bloc.dart';

abstract class MyAppNavigation {
  Map<String, Widget Function(BuildContext)> get routes;
  Route<Object> onGenerateRoute(RouteSettings settings);
  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName);
}

/*class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;
  const MyApp({Key? key, required this.navigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: navigation.routes,
      initialRoute: MainNavigationRouteNames.login,
      onGenerateRoute: navigation.onGenerateRoute,
    );
  }
}*/


class MyApp extends StatefulWidget {
  final MyAppNavigation navigation;
  const MyApp({Key? key, required this.navigation}) : super(key: key);

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // This widget is the root of your application.


  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    NotificationController.requestFirebaseToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notifications - Simple Example',
      navigatorKey: MyApp.navigatorKey,
      onGenerateInitialRoutes:widget.navigation.onGenerateInitialRoutes,
      onGenerateRoute: widget.navigation.onGenerateRoute,
      routes: widget.navigation.routes,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
 }




