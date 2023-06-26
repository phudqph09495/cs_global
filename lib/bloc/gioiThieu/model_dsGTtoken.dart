class ModelDSGtLogin {
  List<ReferCustomer>? referCustomer;

  ModelDSGtLogin({this.referCustomer});

  ModelDSGtLogin.fromJson(Map<String, dynamic> json) {
    if (json['referCustomer'] != null) {
      referCustomer = <ReferCustomer>[];
      json['referCustomer'].forEach((v) {
        referCustomer!.add(new ReferCustomer.fromJson(v));
      });
    }
  }


}

class ReferCustomer {
  int? id;
  String? code;
  String? name;

  String? phone;

  String? password;


  int? score;
  String? balance;
  String? totalCost;
  String? manageFee;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ReferCustomer(
      {this.id,
        this.code,
        this.name,

        this.phone,

        this.password,

        this.score,
        this.balance,
        this.totalCost,
        this.manageFee,
        this.type,

        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  ReferCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];

    phone = json['phone'];

    password = json['password'];

    score = json['score'];
    balance = json['balance'];
    totalCost = json['total_cost'];
    manageFee = json['manage_fee'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
