class ModelListPro {
  Customer? customer;
  Products? products;

  ModelListPro({this.customer, this.products});

  ModelListPro.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.toJson();
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

class Products {
  int? currentPage;
  List<Prod>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Prod>[];
      json['data'].forEach((v) {
        data!.add(new Prod.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Prod {
  int? id;
  String? code;
  String? name;
  String? thumbnail;
  String? originPrice;
  String? price;
  String? vip1Price;
  String? vip2Price;
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
  Pivot? pivot;

  Prod(
      {this.id,
        this.code,
        this.name,
        this.thumbnail,
        this.originPrice,
        this.price,
        this.vip1Price,
        this.vip2Price,
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
        this.pivot});

  Prod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    originPrice = json['origin_price'];
    price = json['price'];
    vip1Price = json['vip1_price'];
    vip2Price = json['vip2_price'];
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['origin_price'] = this.originPrice;
    data['price'] = this.price;
    data['vip1_price'] = this.vip1Price;
    data['vip2_price'] = this.vip2Price;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? productId;

  Pivot({this.categoryId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['product_id'] = this.productId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
