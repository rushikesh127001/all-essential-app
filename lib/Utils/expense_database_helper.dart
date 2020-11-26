import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/Models/expense.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String expensetable = 'expense_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPaid ='paid';
  String colamount='amount';
  String colreaccuring='reaccuring';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = directory.path + 'expense.db';

    // Open/create the database at a given path
    var expensesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return expensesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $expensetable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colamount INTEGER,$colreaccuring INTEGER, $colPaid INTEGER, $colDescription TEXT, $colDate TEXT)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getExpenseMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(expensetable, orderBy: '$colTitle ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertExpense(Expense expense) async {
    Database db = await this.database;
    var result = await db.insert(expensetable,expense.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateExpense(Expense expense) async {
    var db = await this.database;
    var result = await db.update(expensetable, expense.toMap(), where: '$colId = ?', whereArgs: [expense.id]);
    return result;
  }

  Future<int> updateExpenseCompleted(Expense expense) async {
    var db = await this.database;
    var result = await db.update(expensetable, expense.toMap(), where: '$colId = ?', whereArgs: [expense.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteExpense(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $expensetable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $expensetable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Expense>> getExpenseList() async {

    var expenseMaplist = await getExpenseMapList(); // Get 'Map List' from database
    int count = expenseMaplist.length;         // Count the number of map entries in db table

    List<Expense> expenseList = List<Expense>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      expenseList.add(Expense.fromMapObject(expenseMaplist[i]));
    }

    return expenseList;
  }

}







