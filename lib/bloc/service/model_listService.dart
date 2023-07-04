class ModelListService {
  List<Services>? services;

  ModelListService({this.services});

  ModelListService.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? link;
  String? image;
  int? categoryId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Services(
      {this.id,
        this.name,
        this.link,
        this.image,
        this.categoryId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
