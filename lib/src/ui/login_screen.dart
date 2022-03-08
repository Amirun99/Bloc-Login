import 'package:flutter/material.dart';
import 'package:login/src/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(bloc),
            loadingIndicator(bloc)
          ],
        ),
      ),
    );
  }


  Widget loadingIndicator(LoginBloc bloc) =>
      StreamBuilder<bool>(
        stream: bloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  Widget emailField(LoginBloc) =>
      StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snap) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                labelText: "Email Address",
                hintText: 'You@gmail.com',
                errorText: snap.error
            ),
          );
        },
      );

  Widget passwordField(LoginBloc bloc) =>
      StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snap) {
          return TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                errorText: snap.error
            ),
          );
        },
      );

  Widget submitButton(LoginBloc bloc) =>
      StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snap) {
          return ElevatedButton(
            onPressed: (snap.hasData) ? null : bloc.submit,
            child: Text('Login', style: TextStyle(color: Colors.white),),

          );
        },
      );
}
