class ModelChiTietGT {
  List<ReferCustomer>? referCustomer;
  List<OrderCustomer>? orderCustomer;

  ModelChiTietGT({this.referCustomer, this.orderCustomer});

  ModelChiTietGT.fromJson(Map<String, dynamic> json) {
    if (json['referCustomer'] != null) {
      referCustomer = <ReferCustomer>[];
      json['referCustomer'].forEach((v) {
        referCustomer!.add(new ReferCustomer.fromJson(v));
      });
    }
    if (json['orderCustomer'] != null) {
      orderCustomer = <OrderCustomer>[];
      json['orderCustomer'].forEach((v) {
        orderCustomer!.add(new OrderCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referCustomer != null) {
      data['referCustomer'] =
          this.referCustomer!.map((v) => v.toJson()).toList();
    }
    if (this.orderCustomer != null) {
      data['orderCustomer'] =
          this.orderCustomer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferCustomer {
  int? id;
  String? code;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? bankName;
  String? bankCode;
  String? bankAccount;
  String? accountName;
  String? password;
  String? avatar;
  String? banner;
  Null? slogan;
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
  Pivot? pivot;

  ReferCustomer(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.bankName,
        this.bankCode,
        this.bankAccount,
        this.accountName,
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
        this.pivot});

  ReferCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    bankAccount = json['bank_account'];
    accountName = json['account_name'];
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['bank_account'] = this.bankAccount;
    data['account_name'] = this.accountName;
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

class OrderCustomer {
  int? id;
  String? code;
  int? customerId;
  int? createreId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? region;
  String? district;
  String? shipmentPrice;
  String? freeShip;
  String? totalProductPrice;
  String? totalPrice;
  String? couponId;
  String? couponCode;
  String? couponPrice;
  String? note;
  String? score;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderCustomer(
      {this.id,
        this.code,
        this.customerId,
        this.createreId,
        this.customerName,
        this.customerPhone,
        this.customerAddress,
        this.region,
        this.district,
        this.shipmentPrice,
        this.freeShip,
        this.totalProductPrice,
        this.totalPrice,
        this.couponId,
        this.couponCode,
        this.couponPrice,
        this.note,
        this.score,
        this.status,
        this.createdAt,
        this.updatedAt});

  OrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    customerId = json['customer_id'];
    createreId = json['createre_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    region = json['region'];
    district = json['district'];
    shipmentPrice = json['shipment_price'];
    freeShip = json['free_ship'];
    totalProductPrice = json['total_product_price'];
    totalPrice = json['total_price'].toString();
    couponId = json['coupon_id'].toString();
    couponCode = json['coupon_code'].toString();
    couponPrice = json['coupon_price'].toString();
    note = json['note'].toString();
    score = json['score'].toString();
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['customer_id'] = this.customerId;
    data['createre_id'] = this.createreId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['region'] = this.region;
    data['district'] = this.district;
    data['shipment_price'] = this.shipmentPrice;
    data['free_ship'] = this.freeShip;
    data['total_product_price'] = this.totalProductPrice;
    data['total_price'] = this.totalPrice;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['coupon_price'] = this.couponPrice;
    data['note'] = this.note;
    data['score'] = this.score;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
