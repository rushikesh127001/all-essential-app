import 'package:flutter/material.dart';
import 'package:todo_list/Screens/expense_list.dart';
import 'package:todo_list/Screens/shopping_list.dart';
import 'package:todo_list/Screens/todo_list.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: new ListView(
        children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            accountName: Text('blahh'),
            accountEmail: Text('blaghhhh@gmail.com'),
            decoration: BoxDecoration(color: Colors.black87),
          ),

          //body

          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>TodoList()));
            },
            child: ListTile(
              title: Text('My Todo List'),
              leading: Icon(Icons.home),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ExpenseList()));
            },
            child: ListTile(
              title: Text('My Expenses'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ShopList()));

            },
            child: ListTile(
              title: Text('My Shopping List'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Medicine Reminder'),
              leading: Icon(Icons.home),
            ),
          ),


        ],
      ),
    );
  }
}

