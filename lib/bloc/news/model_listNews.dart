class ModelListNews {
  List<AllNews>? allNews;

  ModelListNews({this.allNews});

  ModelListNews.fromJson(Map<String, dynamic> json) {
    if (json['allNews'] != null) {
      allNews = <AllNews>[];
      json['allNews'].forEach((v) {
        allNews!.add(new AllNews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allNews != null) {
      data['allNews'] = this.allNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllNews {
  int? id;
  String? title;
  String? descript;
  int? categoryId;
  String? banner;
  String? status;
  String? createdAt;
  String? updatedAt;

  AllNews(
      {this.id,
        this.title,
        this.descript,
        this.categoryId,
        this.banner,
        this.status,
        this.createdAt,
        this.updatedAt});

  AllNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descript = json['descript'];
    categoryId = json['category_id'];
    banner = json['banner'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descript'] = this.descript;
    data['category_id'] = this.categoryId;
    data['banner'] = this.banner;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
