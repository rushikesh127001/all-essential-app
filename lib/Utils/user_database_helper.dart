import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/Models/todo.dart';
import 'package:todo_list/Models/user.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String todoTable = 'user_table';
  String colId = 'id';
  String colMobilenum = 'username';
  String colPin = 'password';
  String colDate = 'date';

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
    String path = directory.path + 'users.db';

    // Open/create the database at a given path
    var usersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return usersDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPin INTEGER, '
        '$colMobilenum INTEGER, $colDate TEXT)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(todoTable, orderBy: '$colMobilenum ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, user.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateUser(User user) async {
    var db = await this.database;
    var result = await db.update(todoTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> updateTodoCompleted(Todo todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<User>> getUserList() async {

    var todoMapList = await getUserMapList(); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(todoMapList[i]));
    }

    return userList;
  }

}







