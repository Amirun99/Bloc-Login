import 'package:flutter/material.dart';
import 'package:login/src/ui/home_screen.dart';
import 'package:login/src/ui/login_screen.dart';
import 'bloc/authorization_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    authBloc.restoreSession();
    return MaterialApp(
      title: 'Simple Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: createContent(),
    );
  }
  createContent(){
    return StreamBuilder<bool>(

      stream: authBloc.isSessionValid,
      builder: (context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData && snapshot.data){
          return HomeScreen();
        }
        return LoginScreen();
      });
  }
}