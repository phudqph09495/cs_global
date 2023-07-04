class ModelListServiceCate {
  List<ServiceCate>? serviceCate;

  ModelListServiceCate({this.serviceCate});

  ModelListServiceCate.fromJson(Map<String, dynamic> json) {
    if (json['serviceCate'] != null) {
      serviceCate = <ServiceCate>[];
      json['serviceCate'].forEach((v) {
        serviceCate!.add(new ServiceCate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceCate != null) {
      data['serviceCate'] = this.serviceCate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceCate {
  int? id;
  String? name;
  String? image;
  int? position;
  String? status;
  String? createdAt;
  String? updatedAt;

  ServiceCate(
      {this.id,
        this.name,
        this.image,
        this.position,
        this.status,
        this.createdAt,
        this.updatedAt});

  ServiceCate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
