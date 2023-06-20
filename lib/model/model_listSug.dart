class ModelListSugg {
  List<ProductSugges>? productSugges;

  ModelListSugg({this.productSugges});

  ModelListSugg.fromJson(Map<String, dynamic> json) {
    if (json['productSugges'] != null) {
      productSugges = <ProductSugges>[];
      json['productSugges'].forEach((v) {
        productSugges!.add(new ProductSugges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productSugges != null) {
      data['productSugges'] =
          this.productSugges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSugges {
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
  String? status;
  String? createdAt;
  String? updatedAt;
  String? discountPrice;
  List<Null>? flashSale;
  List<Category>? category;

  ProductSugges(
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
        this.status,
        this.createdAt,
        this.updatedAt,
        this.discountPrice,
        this.flashSale,
        this.category});

  ProductSugges.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountPrice = json['discount_price'].toString();

    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
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
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['discount_price'] = this.discountPrice;

    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  Null? image;
  int? position;
  Null? descript;
  Null? parentId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Category(
      {this.id,
        this.name,
        this.image,
        this.position,
        this.descript,
        this.parentId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    descript = json['descript'];
    parentId = json['parent_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['position'] = this.position;
    data['descript'] = this.descript;
    data['parent_id'] = this.parentId;
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
  int? productId;
  int? categoryId;

  Pivot({this.productId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
