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
  String? dateActiveBussiness;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Refer>? refer;
  List<Refer>? beRefered;

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
        this.dateActiveBussiness,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.refer,
        this.beRefered});

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
    score = json['score'];
    balance = json['balance'];
    totalCost = json['total_cost'];
    manageFee = json['manage_fee'];
    type = json['type'];
    dateActiveBussiness = json['date_active_bussiness'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['refer'] != null) {
      refer = <Refer>[];
      json['refer'].forEach((v) {
        refer!.add(new Refer.fromJson(v));
      });
    }
    if (json['beRefered'] != null) {
      beRefered = <Refer>[];
      json['beRefered'].forEach((v) {
        beRefered!.add(new Refer.fromJson(v));
      });
    }
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
    data['date_active_bussiness'] = this.dateActiveBussiness;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.refer != null) {
      data['refer'] = this.refer!.map((v) => v.toJson()).toList();
    }
    if (this.beRefered != null) {
      data['beRefered'] = this.beRefered!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Refer {
  String? code;
  String? name;
  Pivot? pivot;

  Refer({this.code, this.name, this.pivot});

  Refer.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? customerFriendId;
  int? customerId;

  Pivot({this.customerFriendId, this.customerId});

  Pivot.fromJson(Map<String, dynamic> json) {
    customerFriendId = json['customer_friend_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_friend_id'] = this.customerFriendId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
