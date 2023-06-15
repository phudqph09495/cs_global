class ModelProfile {
  Profile? profile;

  ModelProfile({this.profile});

  ModelProfile.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? code;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? password;
  String? avatar;
  String? banner;
  String? slogan;
  Null? deviceToken;
  int? score;
  String? balance;
  String? totalCost;
  String? manageFee;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.password,
        this.avatar,
        this.banner,
        this.slogan,
        this.deviceToken,
        this.score,
        this.balance,
        this.totalCost,
        this.manageFee,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    password = json['password'];
    avatar = json['avatar'];
    banner = json['banner'];
    slogan = json['slogan'];
    deviceToken = json['device_token'];
    score = json['score']??'0';
    balance = json['balance']??'0';
    totalCost = json['total_cost']??'0';
    manageFee = json['manage_fee']??'0';
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
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['banner'] = this.banner;
    data['slogan'] = this.slogan;
    data['device_token'] = this.deviceToken;
    data['score'] = this.score;
    data['balance'] = this.balance;
    data['total_cost'] = this.totalCost;
    data['manage_fee'] = this.manageFee;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
