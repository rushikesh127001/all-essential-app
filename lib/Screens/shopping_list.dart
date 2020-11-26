import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list/Models/shopping.dart';
import 'package:todo_list/Screens/shopping_detail.dart';
import 'package:todo_list/Utils/shop_database_helper.dart';
import 'package:todo_list/Screens/todo_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/Utils/drawer.dart';

class ShopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopListState();
  }
}

class ShopListState extends State<ShopList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Shopping> shoppingList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (shoppingList == null) {
      shoppingList = List<Shopping>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        backgroundColor: Colors.black,
      ),
      drawer: AppDrawer(),
      body: getShopListView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {

            navigateToDetail(Shopping('', '', 0), 'Add Shopping');
          },
          backgroundColor: Colors.lightGreen,
          tooltip: 'Add Shopping',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget getShopListView() {
    return Scaffold(
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Checkbox(
                // checkColor: Colors.greenAccent,
                activeColor: Colors.black87,
                value: this.shoppingList[position].checked==1?true:false,

              ),
//              leading: CircleAvatar(
//                backgroundColor: Colors.black87,
//                child: Text(getFirstLetter(this.shoppingList[position].title),
//                    style: TextStyle(fontWeight: FontWeight.bold)),
//              ),
              title: Text(this.shoppingList[position].title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(this.shoppingList[position].description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.delete,color: Colors.red,),
                    onTap: () {
                      _delete(context, shoppingList[position]);
                    },
                  ),
                ],
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.shoppingList[position], 'Edit Shopping');
              },
            ),
          );
        },
      ),
    );
  }

  // Returns the priority color
  // Color getPriorityColor(int priority) {
  // 	switch (priority) {
  // 		case 1:
  // 			return Colors.red;
  // 			break;
  // 		case 2:
  // 			return Colors.yellow;
  // 			break;

  // 		default:
  // 			return Colors.yellow;
  // 	}
  // }
  getFirstLetter(String title) {
    return title.substring(0, 1);
  }


  // Returns the priority icon
  // Icon getPriorityIcon(int priority) {
  // 	switch (priority) {
  // 		case 1:
  // 			return Icon(Icons.play_arrow);
  // 			break;
  // 		case 2:
  // 			return Icon(Icons.keyboard_arrow_right);
  // 			break;

  // 		default:
  // 			return Icon(Icons.keyboard_arrow_right);
  // 	}
  // }

  void _delete(BuildContext context, Shopping shopping) async {
    int result = await databaseHelper.deleteShopping(shopping.id);
    if (result != 0) {
      _showSnackBar(context, 'Shopping Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Shopping shopping, String title) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShoppingDetail(shopping, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Shopping>> shoppingListFuture = databaseHelper.getShoppingList();
      shoppingListFuture.then((shoppingList) {
        setState(() {
          this.shoppingList = shoppingList;
          this.count = shoppingList.length;
        });
      });
    });
  }


}


