import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list/Models/expense.dart';
import 'package:todo_list/Screens/expense_details.dart';
import 'package:todo_list/Utils/expense_database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/Utils/drawer.dart';

class ExpenseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpenseListState();
  }
}

class ExpenseListState extends State<ExpenseList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Expense> expenselist;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (expenselist == null) {
      expenselist = List<Expense>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense List'),
        backgroundColor: Colors.black,
      ),
      drawer: AppDrawer(),
      body: getShopListView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {

            navigateToDetail(Expense('', '', 0,0,0), 'Add Expense');
          },
          backgroundColor: Colors.lightGreen,
          tooltip: 'Add Expense',
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
                value: this.expenselist[position].paid==1?true:false,

              ),
//              leading: CircleAvatar(
//                backgroundColor: Colors.black87,
//                child: Text(getFirstLetter(this.expenselist[position].title),
//                    style: TextStyle(fontWeight: FontWeight.bold)),
//              ),
              title: Text(this.expenselist[position].title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(this.expenselist[position].description),
              trailing: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,18,0),
                child: Text("Rs: "+this.expenselist[position].amount.toString(),style: TextStyle(fontSize: 20),),
              ),
//              trailing: Row(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  GestureDetector(
//                    child: Icon(Icons.delete,color: Colors.red,),
//                    onTap: () {
//                      _delete(context, expenselist[position]);
//                    },
//                  ),
//                ],
//              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.expenselist[position], 'Edit Expense');
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

  void _delete(BuildContext context, Expense expense) async {
    int result = await databaseHelper.deleteExpense(expense.id);
    if (result != 0) {
      _showSnackBar(context, 'Expense Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Expense expense, String title) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExpenseDetail(expense, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Expense>> shoppingListFuture = databaseHelper.getExpenseList();
      shoppingListFuture.then((expenselist) {
        setState(() {
          this.expenselist = expenselist;
          this.count = expenselist.length;
        });
      });
    });
  }


}


