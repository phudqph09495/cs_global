class ModelOrderDetail {
  Order? order;
  List<OrderDetail>? orderDetail;

  ModelOrderDetail({this.order, this.orderDetail});

  ModelOrderDetail.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['orderDetail'] != null) {
      orderDetail = <OrderDetail>[];
      json['orderDetail'].forEach((v) {
        orderDetail!.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  String? code;
  String? type;
  int? customerId;
  int? createreId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? receiverName;
  String? receiverPhone;
  String? region;
  String? district;
  String? shipmentPrice;
  String? freeShip;
  String? totalProductPrice;
  String? totalPrice;
  int? couponId;
  String? couponCode;
  String? couponPrice;

  String? status;
  String? createdAt;
  String? updatedAt;
  List<OrderDetail>? orderDetail;

  Order(
      {this.id,
        this.code,
        this.type,
        this.customerId,
        this.createreId,
        this.customerName,
        this.customerPhone,
        this.customerAddress,
        this.receiverName,
        this.receiverPhone,
        this.region,
        this.district,
        this.shipmentPrice,
        this.freeShip,
        this.totalProductPrice,
        this.totalPrice,
        this.couponId,
        this.couponCode,
        this.couponPrice,

        this.status,
        this.createdAt,
        this.updatedAt,
        this.orderDetail});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    customerId = json['customer_id'];
    createreId = json['createre_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    region = json['region'];
    district = json['district'];
    shipmentPrice = json['shipment_price'];
    freeShip = json['free_ship'];
    totalProductPrice = json['total_product_price'];
    totalPrice = json['total_price'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    couponPrice = json['coupon_price'];

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetail>[];
      json['order_detail'].forEach((v) {
        orderDetail!.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['customer_id'] = this.customerId;
    data['createre_id'] = this.createreId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['receiver_name'] = this.receiverName;
    data['receiver_phone'] = this.receiverPhone;
    data['region'] = this.region;
    data['district'] = this.district;
    data['shipment_price'] = this.shipmentPrice;
    data['free_ship'] = this.freeShip;
    data['total_product_price'] = this.totalProductPrice;
    data['total_price'] = this.totalPrice;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['coupon_price'] = this.couponPrice;

    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? orderId;
  int? productId;
  String? productName;

  int? amount;
  String? price;
  String? productImg;

  String? status;
  String? createdAt;
  String? updatedAt;

  OrderDetail(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,

        this.amount,
        this.price,
        this.productImg,

        this.status,
        this.createdAt,
        this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];

    amount = json['amount'];
    price = json['price'];
    productImg = json['product_img'];

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;

    data['amount'] = this.amount;
    data['price'] = this.price;
    data['product_img'] = this.productImg;

    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
