class ModelChild {
  List<Child>? child;

  ModelChild({this.child});

  ModelChild.fromJson(Map<String, dynamic> json) {
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  int? id;
  String? name;
  String? image;
  int? position;
  Null? descript;
  int? parentId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Child(
      {this.id,
        this.name,
        this.image,
        this.position,
        this.descript,
        this.parentId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    descript = json['descript'];
    parentId = json['parent_id'];
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
    data['descript'] = this.descript;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
