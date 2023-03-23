import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poliglot/core/cookie_bloc.dart';
import 'package:poliglot/core/drawer.dart';
import 'package:poliglot/core/domain/usecases/updateUserUsecase.dart';
import 'package:poliglot/core/newMessBloc.dart';
//import 'package:poliglot/feature_auth/data/datasources/database_req.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_allusers/presentation/pages/MyApp.dart';
import 'package:poliglot/feature_auth/domain/repositories/authService.dart';
import 'package:poliglot/feature_auth/domain/usecases/sendUserData.dart';
import 'package:poliglot/feature_auth/domain/usecases/getUserData.dart';
import 'package:poliglot/feature_auth/domain/usecases/sendCodeToEmail.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_article/presentation/bloc/search_bloc.dart';
import 'package:poliglot/feature_article/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_auth/data/repositoris/AuthService.dart';
import 'package:poliglot/feature_auth/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_auth/presentation/bloc/LoadUserBloc.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_book/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_login/data/repositoris/AuthService.dart';
import 'package:poliglot/feature_login/domain/repositories/authService.dart';
//import 'package:poliglot/feature_update/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_update/presentation/pages/MainWidgets.dart';
import 'package:poliglot/future_chats/presentation/bloc/allchat_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/chats_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_event.dart';
import 'package:poliglot/future_chats/presentation/bloc/status_user_bloc.dart';
import 'package:poliglot/future_chats/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_main/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_login/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_pass/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_pass/domain/usecases/getUserData.dart';
import 'package:poliglot/feature_pass/domain/usecases/sendCodeToEmail.dart';
import 'package:poliglot/feature_pass/domain/repositories/authService.dart';
import 'package:poliglot/feature_pass/data/repositoris/AuthService.dart';
import 'package:poliglot/feature_pass/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_login/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_login/data/datasources/database_req.dart';
//import 'package:poliglot/feature_login/data/datasources/cookieData.dart';
import 'package:poliglot/feature_login/domain/usecases/getUserData.dart';
import 'package:poliglot/feature_login/domain/usecases/isAuth.dart';
import 'package:poliglot/feature_login/domain/entities/authUser_parser.dart';
import 'package:poliglot/future_chats/presentation/pages/chats_screen.dart';
import 'package:poliglot/future_chats/presentation/pages/home_screen.dart';
import 'package:poliglot/main.dart';
import 'package:poliglot/feature_app/presentation/pages/MyApp.dart';
import 'package:poliglot/feature_app/domain/repositories/authService.dart';
import 'package:poliglot/feature_app/data/repositoris/authService.dart';
import 'package:poliglot/feature_app/domain/entities/authUser_parser.dart';
import 'package:poliglot/feature_app/domain/usecases/isAuth.dart';
//import 'package:poliglot/feature_app/data/datasources/cookieData.dart';
import 'package:poliglot/data/cookieData.dart';
import 'package:poliglot/navigation/MainNavigation.dart';
import 'package:poliglot/core/drawerBloc.dart';
import 'package:poliglot/core/data/repositories/MyDataService.dart';
import 'package:poliglot/core/domain/repositoris/myData.dart';
import 'package:poliglot/core/domain/usecases/MyData.dart';
import 'package:poliglot/core/MyDataBloc.dart';
//import 'package:poliglot/feature_update/presentation/bloc/main_bloc.dart';
//import 'package:poliglot/feature_update/domain/usecases/upateUserusecase.dart';
//import 'package:poliglot/feature_update/domain/repositories/updateServiceData.dart';
//import 'package:poliglot/feature_update/data/repositoris/updateService.dart';
import 'package:poliglot/feature_article/domain/usecases/articleDatauseCase.dart';
import 'package:poliglot/feature_article/domain/repositories/articleServiceData.dart';
import 'package:poliglot/feature_article/data/repositoris/articleService.dart';
import 'package:poliglot/feature_singleArticle/presentation/pages/MainWidgets.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/articleDatauseCase.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/getCookieCase.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/giveLikeCases.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';
import 'package:poliglot/feature_singleArticle/domain/repositories/articleServiceData.dart';
import 'package:poliglot/feature_singleArticle/data/repositoris/articleService.dart';
import 'package:poliglot/feature_allusers/domain/repositories/authService.dart';
import 'package:poliglot/feature_allusers/data/repositoris/AuthService.dart';
import 'package:poliglot/feature_allusers/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_allusers/presentation/bloc/search_userbloc.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

AppFactory makeAppFactory() => _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  final _diContainer = _DIContainer();

  _AppFactoryDefault();

  @override
  Widget makeApp() {
    return   MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
            create: (context) =>_diContainer._makeAppBloc()),
        BlocProvider<StatusBloc>(
            create: (context) =>_diContainer._makeStatusBloc())
      ],
      child: MyApp(navigation: _diContainer.makeMyAppNavigation()),
    );
  }
 /* @override
  Widget makeApp() => BlocProvider(
    create: (_) => _diContainer._makeAppBloc(),
    child: MyApp(navigation: _diContainer.makeMyAppNavigation()),
  );*/
}




class _DIContainer {

  _DIContainer();
 final _clients = HttpClient();
 final _client = http.Client();

  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);

 // DrawerWidget drawer = DrawerWidget();

MyAppNavigation makeMyAppNavigation() =>
      MainNavigation(_makeScreenFactory());



  PersonRemoteDataSource _makeRemoteData()=> PersonRemoteDataSourceImpl(client: _client, clients:_clients);

  AllUserService _makeUserService ()=> UsersService(remoteData: _makeRemoteData());
  
  AllUserBloc _makeUserBloc()=> AllUserBloc(allUser: _makeUserService());
  
  SearchUsersBloc _makeSearchUserBloc ()=> SearchUsersBloc();

  ForgetPassService _makeForgetPassService()=> PasswordService(remoteData:_makeRemoteData());

  SendPasswordToEmail _makeSendPasswordToEmail()=> SendPasswordToEmail(authService: _makeForgetPassService());

  VerifyEmailData _makeVerifyEmailData()=> VerifyEmailData(authService: _makeForgetPassService());

  PassBloc _makePassBloc()=> PassBloc(emailData:_makeVerifyEmailData(), sendPassword: _makeSendPasswordToEmail());

  AuthService _makeAuthService()=> AuthService(remoteData: _makeRemoteData());

  GetUserData _getUserUseCaseData ()=> GetUserData(authService: _makeAuthService());

  SendUserData _sendUserUseCaseData ()=> SendUserData(authService: _makeAuthService());

  SendCodeToEmail _sendCodeUseCaseData ()=> SendCodeToEmail(authService: _makeAuthService());

  CookieData _makeCookieDataProvider ()=> CookieDataProvider();

  CookieDrawerBloc _makeCookieDrawerBloc() => CookieDrawerBloc(cookieData: _makeCookieDataProvider());

  AppServiceLogin _makeServiceLogin ()=>  AppService(cookieData: _makeCookieDataProvider());

  AppIsAuth _makeAppIsAuthUserCase ()=> AppIsAuth(authService: _makeServiceLogin());

  AppBloc _makeAppBloc()=> AppBloc(useCaseApp:_makeAppIsAuthUserCase());

  DrawerBloc _makeDrawer(String select)=> DrawerBloc(useCaseApp:_makeAppIsAuthUserCase(),select:select);

  NewMessBloc _makeNewMessBloc() => NewMessBloc();

  DataUsersBloc _makeDataUsersBloc()=> DataUsersBloc(getData: _getUserUseCaseData(),sendCode:_sendCodeUseCaseData());

  AuthBloc _makeAuthBloc() => AuthBloc(userdata: _sendUserUseCaseData());

  MainBloc _makeMainBloc() => MainBloc();

  BookBloc _makeBookBloc() => BookBloc();
  
  ArticleServiceData _makeArticleService()=> ArticleService(remoteData: _makeRemoteData());
  
  ArticleDataCase _makeArticleDataCase()=> ArticleDataCase(articleService: _makeArticleService());

  ArticlesBloc _makeArticlesBloc() => ArticlesBloc(articleData: _makeArticleDataCase());

  SearchBloc _makeSearchBloc() => SearchBloc();

  //UpdateBloc _makeUpdatesBloc() => UpdateBloc(userdata: _makeUpdateUserUseCase());
 
  //UpdateServiceData _makeUpdateService()=> UpdateService(remoteData: _makeRemoteData());
  
  UpdateUser _makeUpdateUserUseCase()=>UpdateUser(updateService: _makeMyService());
  
  ChatsBloc _makeChatsBloc() => ChatsBloc();
  AllchatsBloc _makeAllChatsBloc() => AllchatsBloc();
  StatusBloc _makeStatusBloc() => StatusBloc();
  StatusUserBloc _makeUserStatusBloc(String name)=> StatusUserBloc(name: name);

  OneArticleServiceData _makeOneArticleService ()=> OneArticleService(remoteData: _makeRemoteData(), cookieData: _makeCookieDataProvider());

  OneArticleDataCase _makeOneArtDataBase ()=> OneArticleDataCase(articleService: _makeOneArticleService());

  CookieOneArtCase _makeCookieCase ()=> CookieOneArtCase(oneArtService: _makeOneArticleService());

  GiveLikeDataCase _makeGiveLikeCase ()=> GiveLikeDataCase(articleService: _makeOneArticleService());
////// bloc ONE ARTICLE //////
  CookieBloc _makeCookieBloc ()=> CookieBloc(useCaseApp: _makeCookieCase());

  OneArticlesBloc _makeOneArticle (Articles data, ArticlesBloc bloc)=>
      OneArticlesBloc(articleData: _makeOneArtDataBase(), giveLikeCase: _makeGiveLikeCase(), data: data);
  //login///////////////////
 // PersonRemoteDataSourceLog _makeLoginRemoteData()=> PersonRemoteDataSourceLogin(client: _client);

  //CookieData _makeCookieDatarovider()=> CookieDataProvider();

  AuthServiceLogin _makeAuthLogin()=> LoginService(remoteData: _makeRemoteData(), cookieData: _makeCookieDataProvider());

  GetLoginData _makeLoginData() => GetLoginData(authService: _makeAuthLogin());

  IsAuth _makeIsAuth()=> IsAuth(authService: _makeAuthLogin());

  LoginBloc _makeLoginBloc() => LoginBloc(userdata: _makeLoginData(), authData: _makeIsAuth());
  //////////////////////////////дровер личная инфа
MyInfoService _makeMyService()=> MyDataService(remoteData: _makeRemoteData(), cookieData: _makeCookieDataProvider());

GetMyData _makeMyUsecasesData()=> GetMyData(myDataService: _makeMyService());

MyDataBloc _makeMyDataBloc()=> MyDataBloc(myData: _makeMyUsecasesData(),userdata:_makeUpdateUserUseCase());
}


class ScreenFactoryDefault implements ScreenFactory{
  final _DIContainer _diContainer;
  late ArticlesBloc bloc;


   ScreenFactoryDefault(this._diContainer);

@override
Widget makeUserScreen(){
  return MultiBlocProvider(
    providers: [ //сдел еще один блокпровидер из полного артикла
      BlocProvider<SearchUsersBloc>(
          create: (context) =>_diContainer._makeSearchUserBloc()),
      BlocProvider<AllUserBloc>(
          create: (context) =>_diContainer._makeUserBloc()),
      BlocProvider<CookieBloc>(
          create: (context) =>_diContainer._makeCookieBloc()),
    ],
    child: UsersDataWidget(drawerWidget: makeDrawer('Users'),),
  );
}
   
   
  @override
  Widget makeOneArticle(Articles data) {
    return  MultiBlocProvider(
      providers: [ //сдел еще один блокпровидер из полного артикла
        BlocProvider<ArticlesBloc>(
            create: (context) =>bloc),
        BlocProvider<OneArticlesBloc>(
            create: (context) =>_diContainer._makeOneArticle(data,bloc)),
        BlocProvider<CookieBloc>(
            create: (context) =>_diContainer._makeCookieBloc()),
      ],
      child:  OneArticleDataWidget(id:data.id),
    );
  }

  @override
  Widget makeAuth() {
    return   MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) =>_diContainer._makeAuthBloc()),
        BlocProvider<DataUsersBloc>(
            create: (context) =>_diContainer._makeDataUsersBloc()),
      ],
      child: const AuthDataWidget(),
    );
  }

  @override
  Widget makeLoginScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makeLoginBloc(),
      child:  const LoginDataWidget(),
    );
  }

  @override
  Widget makeDrawer(String select) {
    return   MultiBlocProvider(
      providers: [
        BlocProvider<CookieDrawerBloc>(
            create: (context) =>_diContainer._makeCookieDrawerBloc()),
        BlocProvider<DrawerBloc>(
            create: (context) =>_diContainer._makeDrawer(select)),
        BlocProvider<MyDataBloc>(
            create: (context) =>_diContainer._makeMyDataBloc()),
        BlocProvider<NewMessBloc>(
            create: (context) =>_diContainer._makeNewMessBloc()),
      ],
      child: DrawerWidget(),
    );
  }

  /*@override
  Widget makeDrawer(String select) {
    return BlocProvider(
      create: (_) => _diContainer._makeDrawer(select),
      child:  DrawerWidget(),
    );
  }*/

  @override
  Widget makeMainScreen() {
    return BlocProvider(
    create: (_) => _diContainer._makeMainBloc(),
    child:  MainDataWidget(drawerWidget: makeDrawer('Main')),
  );
  }

  @override
  Widget makePassScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makePassBloc(),
      child: const PasswordDataWidget(),
    );
  }

  @override
 Widget makeBooksScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makeBookBloc(),
      child:  BookDataWidget(drawerWidget: makeDrawer('Books')),
    );
  }

  @override
  Widget makeUpdateScreen(User user) {
    return BlocProvider(
      create: (_) => _diContainer._makeMyDataBloc(),
      child: UpdateDataWidget(drawerWidget: makeDrawer('Update'),user:user),
    );
  }

  @override
  Widget makeChatsScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CookieBloc>(
            create: (context) =>_diContainer._makeCookieBloc()),
        BlocProvider<CookieBloc>(
            create: (context) =>_diContainer._makeCookieBloc()),
        BlocProvider<AllchatsBloc>(
            create: (context) =>_diContainer._makeAllChatsBloc()),
        BlocProvider<ChatsBloc>(
            create: (context) =>_diContainer._makeChatsBloc()),
        BlocProvider<StatusBloc>(
            create: (context) => _diContainer._makeStatusBloc()),
        /*  BlocProvider<StatusUserBloc>(
                   create: (context) => StatusUserBloc()),*/
      ],
      child: ChatsInfoState(drawerWidget: makeDrawer('Chats')),
    );
   /* return BlocProvider(
      create: (_) => _diContainer._makeChatsBloc(),
      child:  ChatsDataWidget(drawerWidget: makeDrawer('Chats')),
    );*/
  }

  @override
  Widget makeMessageScreen(){
    return MultiBlocProvider(
        providers: [
          BlocProvider<CookieBloc>(
              create: (context) =>_diContainer._makeCookieBloc()),
          BlocProvider<StatusUserBloc>(
              create: (context) =>_diContainer._makeUserStatusBloc(NotificationController().initialAction!.title as String)),
          BlocProvider<AllchatsBloc>(
              create: (context) =>_diContainer._makeAllChatsBloc()),
        ],
        child: MessageScreen(
            arg:{
              'idchat':NotificationController().initialAction!.payload!['id'] as String,
              'name':NotificationController().initialAction!.title as String
            }));
  }

  @override
  Widget makeMessageScreenNavigation(Map data){
    return MultiBlocProvider(
        providers: [
          BlocProvider<CookieBloc>(
              create: (context) =>_diContainer._makeCookieBloc()),
          BlocProvider<StatusUserBloc>(
              create: (context) =>_diContainer._makeUserStatusBloc( (data as Map<String,dynamic>)['name'] as String)),
          BlocProvider<AllchatsBloc>(
              create: (context) =>_diContainer._makeAllChatsBloc()),
        ],
        child: MessageScreen(
            arg:data));
  }

  @override
  Widget makeArticlesScreen() {
    bloc = _diContainer._makeArticlesBloc();
    return   MultiBlocProvider(
      providers: [
        BlocProvider<ArticlesBloc>(
            create: (context) =>bloc),
        BlocProvider<SearchBloc>(
            create: (context) =>_diContainer._makeSearchBloc()),
      ],
      child:  ArticlesDataWidget(drawerWidget: makeDrawer('Articles')),
    );
  }
/*@override
  Widget makeMainScreen() {
    return MainScreenWidget(screenFactory: this);
  }

  @override
  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeMovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  @override
  Widget makeMovieTrailer(String youtubeKey) {
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }

  @override
  Widget makeNewsList() {
    return const NewsWidget();
  }

  @override
  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeMovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  @override
  Widget makeTWShowList() {
    return const TWShowListWidget();
  }*/
}
