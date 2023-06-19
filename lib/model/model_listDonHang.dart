class ModelListDonHang {
  List<Orders>? orders;

  ModelListDonHang({this.orders});

  ModelListDonHang.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
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
  int? couponId;
  String? couponCode;
  String? couponPrice;
  Null? note;
  Null? score;
  String? status;
  String? createdAt;
  String? updatedAt;

  Orders(
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

  Orders.fromJson(Map<String, dynamic> json) {
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
    totalPrice = json['total_price'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    couponPrice = json['coupon_price'];
    note = json['note'];
    score = json['score'];
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
