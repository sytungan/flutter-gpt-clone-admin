class UserModel {
  String? username;
  String? useremail;
  String? phone;
  String? password;
  String? id;
  String? ref;
  bool? purchased;
  bool? isMonthly;
  bool? isPortal;
  String? purchasedAt;
  String? tokens;
  String? timeagoe;
  String? package;
  String? messages;
  int? remin;

  UserModel({
    this.useremail,
    this.messages,
    this.username,
    this.phone,
    this.id,
    this.ref,
    this.password,
    this.package,
    this.isMonthly,
    this.isPortal,
    this.purchased,
    this.purchasedAt,
    this.timeagoe,
    this.remin,
    this.tokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      messages: json["messages"] ?? '',
      id: json["id"],
      useremail: json["useremail"] ?? '',
      phone: json["phone"] ?? '',
      username: json["username"],
      ref: json['ref'],
      password: json["password"],
      isMonthly: json['isMonthly'],
      isPortal: json['isPortal'],
      purchased: json['purchased'],
      purchasedAt: json['purchasedAt'],
      tokens: json['tokens'] ?? '0',
      remin: json['remain'] ?? 0,
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
        'isMonthly': isMonthly,
        'isPortal': isPortal,
        'purchased': purchased,
        'purchasedAt': purchasedAt,
        'tokens': tokens,
        'remain': remin,
        'timeagoe': timeagoe,
        'package': package,
      };
}
