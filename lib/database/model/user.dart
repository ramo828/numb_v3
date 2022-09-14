class userDB {
  int? id;
  String? user;
  String? password;

  userDB({this.id, this.user, this.password});

  userDB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['password'] = password;
    return data;
  }
}
