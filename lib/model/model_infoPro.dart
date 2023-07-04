class ModelInfoPro {

  Product? product;

  ModelInfoPro({ this.product});

  ModelInfoPro.fromJson(Map<String, dynamic> json) {

    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? type;

  Customer({this.name, this.type});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Product {
  int? id;
  String? code;
  String? name;
  String? thumbnail;
  String? originPrice;
  String? price;
  String? fsPrice;
  int? discountCtv;
  int? discountDl;
  int? discountTnkd;
  int? discountQlkd;
  int? sold;
  int? score;
  String? hotProduct;
  int? amount;
  String? descript;
  String? manualUser;
  String? supplierInfo;
  String? legalInfo;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? isFlashSale;
  String? discountPrice;
  String? discount;
  int? averageStar;
  List<Null>? property;
  List<ImagesShow>? imagesShow;
  List<Null>? flashSale;
  List<Comments>? comments;

  Product(
      {this.id,
        this.code,
        this.name,
        this.thumbnail,
        this.originPrice,
        this.price,
        this.fsPrice,
        this.discountCtv,
        this.discountDl,
        this.discountTnkd,
        this.discountQlkd,
        this.sold,
        this.score,
        this.hotProduct,
        this.amount,
        this.descript,
        this.manualUser,
        this.supplierInfo,
        this.legalInfo,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isFlashSale,
        this.discountPrice,
        this.discount,
        this.averageStar,
        this.property,
        this.imagesShow,
        this.flashSale,
        this.comments});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    originPrice = json['origin_price'];
    price = json['price'];
    fsPrice = json['fs_price'];
    discountCtv = json['discount_ctv'];
    discountDl = json['discount_dl'];
    discountTnkd = json['discount_tnkd'];
    discountQlkd = json['discount_qlkd'];
    sold = json['sold'];
    score = json['score'];
    hotProduct = json['hot_product'];
    amount = json['amount'];
    descript = json['descript'];
    manualUser = json['manual_user'];
    supplierInfo = json['supplier_info'];
    legalInfo = json['legal_info'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFlashSale = json['is_flashSale'];
    discountPrice = json['discount_price'];
    discount = json['discount'];
    averageStar = json['average_star'];

    if (json['images_show'] != null) {
      imagesShow = <ImagesShow>[];
      json['images_show'].forEach((v) {
        imagesShow!.add(new ImagesShow.fromJson(v));
      });
    }

    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['origin_price'] = this.originPrice;
    data['price'] = this.price;
    data['fs_price'] = this.fsPrice;
    data['discount_ctv'] = this.discountCtv;
    data['discount_dl'] = this.discountDl;
    data['discount_tnkd'] = this.discountTnkd;
    data['discount_qlkd'] = this.discountQlkd;
    data['sold'] = this.sold;
    data['score'] = this.score;
    data['hot_product'] = this.hotProduct;
    data['amount'] = this.amount;
    data['descript'] = this.descript;
    data['manual_user'] = this.manualUser;
    data['supplier_info'] = this.supplierInfo;
    data['legal_info'] = this.legalInfo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_flashSale'] = this.isFlashSale;
    data['discount_price'] = this.discountPrice.toString();
    data['discount'] = this.discount;
    data['average_star'] = this.averageStar;

    if (this.imagesShow != null) {
      data['images_show'] = this.imagesShow!.map((v) => v.toJson()).toList();
    }

    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImagesShow {
  int? id;
  int? productId;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  ImagesShow(
      {this.id,
        this.productId,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  ImagesShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Comments {
  int? id;
  int? customerId;
  int? productId;
  String? descript;
  int? star;
  String? status;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
        this.customerId,
        this.productId,
        this.descript,
        this.star,
        this.status,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    descript = json['descript'];
    star = json['star'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['descript'] = this.descript;
    data['star'] = this.star;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
