import 'package:flutter/material.dart';
import 'package:login/src/ui/home_screen.dart';
import 'package:login/src/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';


class AuthorizationBloc{
  String _tokenString = "";
  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;

  void dispose(){
    _isSessionValid.close();
  }
  void restoreSession() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.get('token');
    if (_tokenString != null && _tokenString.length>0){
      _isSessionValid.sink.add(true);
    }else{
      _isSessionValid.sink.add(false);
    }
  }
  void openSession(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = token;
    _isSessionValid.sink.add(true);
  }
  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    _isSessionValid.sink.add(false);
  }
}
final authBloc = AuthorizationBloc();

createContent(){
  return StreamBuilder<bool>(
    stream: authBloc.isSessionValid,
    builder: (context, AsyncSnapshot<bool> snapshot){
      if (snapshot.hasData && snapshot.data){
        return HomeScreen();
      }
      return LoginScreen();
    }
  );
}