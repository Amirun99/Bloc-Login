import 'package:flutter/material.dart';
import 'package:login/src/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  HomeBloc bloc = HomeBloc();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),
      actions: <Widget>[
        IconButton(
          icon : const Icon(Icons.logout),
          tooltip:'Default',
          onPressed: bloc.logoutUser,
        )
      ],
      ),
      body: Center(
        child: Text('Welcome to Home Page', style: TextStyle(fontSize: 32))
      ),
    );
  }
}