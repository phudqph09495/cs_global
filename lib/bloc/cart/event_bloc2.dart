
import '../../model/model_infoPro.dart';
import 'model_sp.dart';

abstract class EventBloc2 {}
class AddData extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  AddData({required this.modelSanPhamMain});
}
class Reduce extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  Reduce({required this.modelSanPhamMain});
}
class ClearAll extends EventBloc2{}
class GetCart extends EventBloc2{
String type;
GetCart({this.type='ban_than'});
}
class CreateOrder extends EventBloc2 {
  String? type;
  String? receiver_name;
  String? receiver_phone;
  String? district;
  String? region;
  String? address;
  Coupon? coupon;
  List<Products>? products;
  String? freeShip;
  int? shipmentCost;
  int? totalProductPrice;
  int? totalPrice;


  CreateOrder(
      {this.district,
        this.region,
        this.coupon,
        this.address,
        this.products,
        this.freeShip,
        this.shipmentCost,
        this.totalProductPrice,
        this.totalPrice,
        this.type,this.receiver_name,this.receiver_phone
        // this.score
      });

  CreateOrder.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    region = json['region'];
    address = json['address'];
    coupon =
    json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    freeShip = json['free_ship'];
    shipmentCost = json['shipment_cost'];
    totalProductPrice = json['total_product_price'];
    totalPrice = json['total_price'];
    // score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type']=this.type;
    data['receiver_name']=this.receiver_name;
    data['receiver_phone']=this.receiver_phone;
    data['district'] = this.district;
    data['region'] = this.region;
    data['address'] = this.address;
    if (this.coupon != null&&this.coupon!.id!=null) {
      data['coupon'] = this.coupon!.toJson();
    }else{
      data['coupon']=null;
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }

    data['free_ship'] = this.freeShip;
    data['shipment_cost'] = this.shipmentCost;
    data['total_product_price'] = this.totalProductPrice;
    data['total_price'] = this.totalPrice;
    // data['score'] = this.score;
    return data;
  }
}

class Coupon {
  int? id;
  String? code;
  String? price;

  Coupon({this.id, this.code, this.price});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    price = json['price']??'0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['price'] = this.price;
    return data;
  }
}

class Products {
  int? quanty;
  int? price;
  Product? productInfo;


  Products({this.quanty, this.price, this.productInfo, });

  Products.fromJson(Map<String, dynamic> json) {
    quanty = json['quanty'];
    price = json['price'];
    productInfo = json['productInfo'] != null
        ? new Product.fromJson(json['productInfo'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quanty'] = this.quanty;
    data['price'] = this.price;
    if (this.productInfo != null) {
      data['productInfo'] = this.productInfo!.toJson();
    }
    // data['propertyInfo']=null;

    return data;
  }
}




