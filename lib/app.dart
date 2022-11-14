
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfindapp/auth/repository_auth.dart';
import 'package:musicfindapp/bloc/auth_bloc.dart';
import 'package:musicfindapp/bloc/findmusic_bloc.dart';
import 'package:musicfindapp/router/app_routes.dart';
import 'package:musicfindapp/screens/home_screen.dart';
import 'package:musicfindapp/screens/login_screen.dart';
import 'package:musicfindapp/themes/app_theme.dart';

// class App extends StatelessWidget{
//   const App({Key? key,required this.authenticationRepository}) : super(key: key);
//   final AuthenticationRepository authenticationRepository;
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (context) => AuthBloc(authenticationRepository: authenticationRepository),
//         ),
//         BlocProvider<FindmusicBloc>(
//           create: (context) => FindmusicBloc(),
//         ),
//       ],
//       child: const MyApp(),
//     );
//   }
// }
class App extends StatelessWidget{
  const App({Key? key,required this.authenticationRepository}) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authenticationRepository: authenticationRepository),
          ),
          BlocProvider<FindmusicBloc>(
            create: (context) => FindmusicBloc(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  AppViewState createState() => AppViewState();
}

  class AppViewState extends State<MyApp>{
  final _navigatorKey = GlobalKey<NavigatorState>();
   NavigatorState? get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material App',
    // initialRoute: AppRoutes.initialRoute,
    routes: AppRoutes.getAppRoutes(),
    onGenerateRoute: AppRoutes.onGenerateRoute,
    theme: AppTheme.darkTheme,
    home: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              print(state.status);
              if(state.status == AuthStatus.authenticated){
                return const HomeScreen();
                // _navigator?.pushNamedAndRemoveUntil('home', (route) => false);
              }else if(state.status == AuthStatus.unauthenticated || state.status == AuthStatus.unknown){
                return const LoginScreen();
                // _navigator?.pushNamedAndRemoveUntil('login', (route) => false);
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            listener: (context, state) {}),
    // builder: (context,child){
    //   return BlocListener<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     print(state.status);
    //       final routes = AppRoutes.getAppRoutes();
    //       print(routes);
        
    //   },
    //   child: child,
    // );
    // }
      );
  }
}


