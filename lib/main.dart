import 'package:firebase_auth/firebase_auth.dart';
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
					backgroundColor: Colors.black,
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
	TextEditingController mobilenumController=TextEditingController();
	TextEditingController otpController=TextEditingController();

	@override
  Widget build(BuildContext context) {
    return Center(
			child: Padding(
			  padding: const EdgeInsets.all(15.0),
			  child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
			  	children: [
			  		Padding(
							padding: EdgeInsets.all(15),
			  			child: TextField(
			  				keyboardType: TextInputType.number,
			  				controller: mobilenumController,
			  				maxLength: 10,
			  				onChanged: (value) {
			  					debugPrint('Something changed in Amount Text Field');
			  				},
			  				decoration: InputDecoration(
			  						labelText: 'Mobile Number',
			  						border: OutlineInputBorder(
			  								borderRadius: BorderRadius.circular(5.0)
			  						)
			  				),
			  			),
			  		),
						Padding(
							padding: EdgeInsets.all(15),
							child: TextField(
								keyboardType: TextInputType.number,
								controller: otpController,
								onChanged: (value) {
									debugPrint('Something changed in Amount Text Field');
								},
								decoration: InputDecoration(
										labelText: 'OTP Please',
										border: OutlineInputBorder(
												borderRadius: BorderRadius.circular(5.0)
										)
								),
							),
						),
						Padding(
						  padding: const EdgeInsets.all(8.0),
						  child: RaisedButton.icon(onPressed: ()async{


							},
								icon: Text("Submit"), label: Icon(Icons.check_circle),color: Colors.lightGreen,),
						)
			  	],
			  ),
			)
		);
  }
}

