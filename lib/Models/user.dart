class User {
  int _id;
  String _username;
  String _password;
  User(this._username, this._password);
  User.withid(this._id,this._username, this._password);
  int get id => _id;
  int get username => _username;
  int get password => _password;
  User.fromMapObject(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
  }
  String get username => _username;
  String get password => _password;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}