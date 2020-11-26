import 'package:flutter/material.dart';
import 'package:todo_list/Screens/todo_list.dart';
import 'package:todo_list/Screens/todo_detail.dart';
import 'package:todo_list/Utils/drawer.dart';

void main() {
	runApp(TodoApp());
}

class TodoApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'TodoList',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.blue
	    ),
	    home: Scaffold(
				body: MainPage(),//Center(child: Text("Go To Navbar"),),
				drawer: AppDrawer(),
				appBar: AppBar(
					title: Text("The Essential Utility App"),
				),
			),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
			child: LoginScreen(),
		);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
			child: Text("hii"),
		);
  }
}

