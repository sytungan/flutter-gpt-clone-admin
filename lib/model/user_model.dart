class UserModel {
  String? username;
  String? useremail;
  String? phone;
  String? password;
  String? id;
  String? ref;
  bool? purchased;
  String? tokens;
  String? timeagoe;
  String? package;
  String? messages;
  int? remin;

  UserModel(
      {this.useremail,
      this.messages,
      this.username,
      this.phone,
      this.id,
      this.ref,
      this.password,
      this.package,
      this.purchased,
      this.timeagoe,
      this.remin,
      this.tokens});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      messages: json["messages"]??'',
      id: json["id"],
      useremail: json["useremail"]??'',
      phone: json["phone"]??'',
      username: json["username"],
      ref: json['ref'],
      password: json["password"],
      purchased: json['purchased'],
      tokens: json['tokens']??'0',
      remin: json['remain']??0,
      timeagoe: json["timeagoe"],
      package: json['package'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "messages": messages,
        "useremail": useremail,
        "phone": phone,
        "id": id,
        'ref': ref,
        "password": password,
        'purchased': purchased,
        'tokens': tokens,
        'remain': remin,
        'timeagoe': timeagoe,
        'package': package,
      };
}
