import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/navigation/MainNavigationRouteNames.dart';
import 'package:poliglot/feature_app/presentation/pages/MyApp.dart';
import 'package:poliglot/main.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


abstract class ScreenFactory {
  Widget makeLoginScreen();
  Widget makeAuth();
  Widget makeMainScreen();
  Widget makeArticlesScreen();
  Widget makeOneArticle(Articles data);
  Widget makeBooksScreen();
//  Widget makeOneBookScreen();
  Widget makeChatsScreen();
  Widget makeMessageScreen();
  Widget makeUpdateScreen(User user);
  Widget makePassScreen();
  Widget makeDrawer(String select);
  Widget makeMessageScreenNavigation(Map data);
  Widget makeUserScreen();
}

class MainNavigation implements MyAppNavigation{
  final ScreenFactory screenFactory;

  const MainNavigation(this.screenFactory);

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
    MainNavigationRouteNames.login: (_) =>
        screenFactory.makeLoginScreen(),
    MainNavigationRouteNames.auth: (_) =>
        screenFactory.makeAuth(),
    MainNavigationRouteNames.mainScreen: (_) =>
        screenFactory.makeMainScreen(),
    MainNavigationRouteNames.articlesScreen: (_) =>
        screenFactory.makeArticlesScreen(),
    MainNavigationRouteNames.booksScreen: (_) =>
        screenFactory.makeBooksScreen(),
   /* MainNavigationRouteNames.updateScreen: (_) =>
        screenFactory.makeUpdateScreen(),*/
    MainNavigationRouteNames.chatsScreen: (_) =>
        screenFactory.makeChatsScreen(),
    MainNavigationRouteNames.forgetPass:(_) =>
        screenFactory.makePassScreen(),
    MainNavigationRouteNames.allusers:(_) =>
        screenFactory.makeUserScreen(),
  };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
   switch (settings.name) {
      case MainNavigationRouteNames.updateScreen:
        final arguments = settings.arguments;
        final user = arguments is User ? arguments:
          const User(name: '', job:'', activity: '', email: '', country: '', age: '', story: '', language: '', userid: '', date: '', image: '', password: '');
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeUpdateScreen(user),
        );
        
      case MainNavigationRouteNames.messageScreen:
        final arguments = settings.arguments;
        final thisArg  = arguments is Map? arguments: settings.arguments is ReceivedAction?
        {'idchat':(settings.arguments as ReceivedAction).payload!['id'] as String,'name':(settings.arguments as ReceivedAction).title as String}
            :{'idchat':'','name':''};
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeMessageScreenNavigation(thisArg),
        );
     case MainNavigationRouteNames.oneArticleScreen:
       final arguments = settings.arguments;
       final data = arguments is Articles ? arguments: const Articles(id: 0, image: '', category: '', time: '', views: 0, header: '', twoheader: '', text: '', likes: []);
       return MaterialPageRoute(
         builder: (_) => screenFactory.makeOneArticle(data),
       );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

@override
  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(
        builder: (_) => screenFactory.makeLoginScreen()
        ));
    if (initialRouteName == MainNavigationRouteNames.messageScreen &&
        NotificationController().initialAction != null) {
      pageStack.add(MaterialPageRoute(
        builder: (_) => screenFactory.makeMessageScreen(),
        /* HomeScreen(
              arg:{
                'idchat':NotificationController().initialAction!.payload!['id'] as String,
                'name':NotificationController().initialAction!.title as String
              })*/));
    }
    return pageStack;
  }
}
