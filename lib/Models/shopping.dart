import 'package:flutter/material.dart';

class Shopping {

  int _id;
  String _title;
  String _description;
  String _date;
  int _checked=0;

  Shopping(this._title, this._date,this._checked, [this._description] );

  Shopping.withId(this._id, this._title, this._date,this._checked, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get checked=>_checked;


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }
  set checked(int newchecked){
    this._checked=newchecked;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['checked']=_checked;

    return map;
  }

  // Extract a Note object from a Map object
  Shopping.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._checked=map['checked'];
  }
}









