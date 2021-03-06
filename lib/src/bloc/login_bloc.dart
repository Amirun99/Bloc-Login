
import 'dart:async';

import 'package:login/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'authorization_bloc.dart';

class LoginBloc extends Object  {
  Repository repository = Repository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatepassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email,password, (email,password)=> true);
  Stream<bool> get loading => _loadingData.stream;

  StreamTransformer<dynamic, String> get validatepassword => null;
  StreamTransformer<dynamic, String> get validateEmail => null;



  void submit(){
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }
  login (String email, String password) async{
    String token = await repository.login(email,password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }

}