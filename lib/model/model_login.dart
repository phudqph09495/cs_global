class ModelLogin {
  Customer? customer;
  Token? token;

  ModelLogin({this.customer, this.token});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? code;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? userName;
  String? password;
  String? gender;
  Null? avatar;
  Null? deviceToken;
  int? score;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.userName,
        this.password,
        this.gender,
        this.avatar,
        this.deviceToken,
        this.score,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    userName = json['user_name'];
    password = json['password'];
    gender = json['gender'];
    avatar = json['avatar'];
    deviceToken = json['device_token'];
    score = json['score'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['device_token'] = this.deviceToken;
    data['score'] = this.score;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Token {
  String? code;
  String? status;
  String? message;
  Data? data;

  Token({this.code, this.status, this.message, this.data});

  Token.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
