class ModelListNewCate {
  List<NewsCate>? newsCate;

  ModelListNewCate({this.newsCate});

  ModelListNewCate.fromJson(Map<String, dynamic> json) {
    if (json['newsCate'] != null) {
      newsCate = <NewsCate>[];
      json['newsCate'].forEach((v) {
        newsCate!.add(new NewsCate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsCate != null) {
      data['newsCate'] = this.newsCate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsCate {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  NewsCate({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  NewsCate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
