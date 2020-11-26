
class Expense {

  int _id;
  String _title;
  String _description;
  String _date;
  int _amount;
  int _reaccuring;
  int _paid=0;
  Expense(this._title, this._date,this._amount,this._reaccuring,this._paid, [this._description] );

  Expense.withId(this._id, this._title, this._date,this._amount,this._reaccuring,this._paid, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;
  int get amount=>_amount;
  int get reaccuring=>_reaccuring;
  int get paid=> _paid;


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
  set amount(int newamt){
    this._amount=newamt;
  }
  set reaccuring(int isreaccuring){
    this._reaccuring=isreaccuring;
  }
  set paid(int paidnew){
    this._paid=paidnew;
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
    map['amount']=_amount;
    map['reaccuring']=_reaccuring;
    map['paid']=this._paid;

    return map;
  }

  // Extract a Note object from a Map object
  Expense.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._amount=map['amount'];
    this._reaccuring=map['reaccuring'];
    this._paid=map['paid'];
  }
}









