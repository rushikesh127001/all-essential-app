import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/Models/shopping.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String shoppingtable = 'shopping_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colChecked ='checked';

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
    String path = directory.path + 'shopping.db';

    // Open/create the database at a given path
    var shoppingsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return shoppingsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $shoppingtable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colChecked INTEGER, $colDescription TEXT, $colDate TEXT)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getShoppingMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(shoppingtable, orderBy: '$colTitle ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertShopping(Shopping shopping) async {
    Database db = await this.database;
    var result = await db.insert(shoppingtable,shopping.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateShopping(Shopping shopping) async {
    var db = await this.database;
    var result = await db.update(shoppingtable, shopping.toMap(), where: '$colId = ?', whereArgs: [shopping.id]);
    return result;
  }

  Future<int> updateShoppingCompleted(Shopping shopping) async {
    var db = await this.database;
    var result = await db.update(shoppingtable, shopping.toMap(), where: '$colId = ?', whereArgs: [shopping.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteShopping(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $shoppingtable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $shoppingtable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Shopping>> getShoppingList() async {

    var shoppingMapList = await getShoppingMapList(); // Get 'Map List' from database
    int count = shoppingMapList.length;         // Count the number of map entries in db table

    List<Shopping> shoppingList = List<Shopping>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      shoppingList.add(Shopping.fromMapObject(shoppingMapList[i]));
    }

    return shoppingList;
  }

}







