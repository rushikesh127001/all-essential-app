import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list/Models/shopping.dart';
import 'package:todo_list/Utils/shop_database_helper.dart';
import 'package:intl/intl.dart';

class ShoppingDetail extends StatefulWidget {

  final String appBarTitle;
  final Shopping shopping;

  ShoppingDetail(this.shopping, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return ShoppingDetailState(this.shopping, this.appBarTitle);
  }
}

class ShoppingDetailState extends State<ShoppingDetail> {

  //static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();
  bool checkval=false;
  String appBarTitle;
  Shopping shopping;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ShoppingDetailState(this.shopping, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = shopping.title;
    descriptionController.text = shopping.description;


    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First element
                // ListTile(
                //   title: DropdownButton(
                // 	    items: _priorities.map((String dropDownStringItem) {
                // 	    	return DropdownMenuItem<String> (
                // 			    value: dropDownStringItem,
                // 			    child: Text(dropDownStringItem),
                // 		    );
                // 	    }).toList(),

                // 	    style: textStyle,

                // 	    value: getPriorityAsString(shopping.priority),

                // 	    onChanged: (valueSelectedByUser) {
                // 	    	setState(() {
                // 	    	  debugPrint('User selected $valueSelectedByUser');
                // 	    	  updatePriorityAsInt(valueSelectedByUser);
                // 	    	});
                // 	    }
                //   ),
                // ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Row(

                  children: [
                    Checkbox(
                     // checkColor: Colors.greenAccent,
                      activeColor: Colors.black87,
                      value: shopping.checked==1?true:false,
                      onChanged: (bool value) {
                        setState(() {
                          this.checkval = value;
                          print(this.checkval);

                        });
                        updateChecklist();

                      },
                    ),
                    Text("Completed"),
                  ],
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  // void updatePriorityAsInt(String value) {
  // 	switch (value) {
  // 		case 'High':
  // 			shopping.priority = 1;
  // 			break;
  // 		case 'Low':
  // 			shopping.priority = 2;
  // 			break;
  // 	}
  // }

  // Convert int priority to String priority and display it to user in DropDown
  // String getPriorityAsString(int value) {
  // 	String priority;
  // 	switch (value) {
  // 		case 1:
  // 			priority = _priorities[0];  // 'High'
  // 			break;
  // 		case 2:
  // 			priority = _priorities[1];  // 'Low'
  // 			break;
  // 	}
  // 	return priority;
  // }

  // Update the title of shopping object
  void updateTitle(){
    shopping.title = titleController.text;
  }

  // Update the description of shopping object
  void updateDescription() {
    shopping.description = descriptionController.text;
  }
  void updateChecklist(){
    // == 0 ? false : true;
    int temp=checkval?1:0;

    shopping.checked=temp;
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    shopping.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (shopping.id != null) {  // Case 1: Update operation
      result = await helper.updateShopping(shopping);
    } else { // Case 2: Insert Operation
      result = await helper.insertShopping(shopping);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Todo Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Todo');
    }

  }


  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW shopping i.e. he has come to
    // the detail page by pressing the FAB of todoList page.
    if (shopping.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    // Case 2: User is trying to delete the old shopping that already has a valid ID.
    int result = await helper.deleteShopping(shopping.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Todo Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Todo');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}










