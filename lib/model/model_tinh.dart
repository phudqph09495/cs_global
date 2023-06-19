class ModelTinh {
  List<Regions>? regions;

  ModelTinh({this.regions});

  ModelTinh.fromJson(Map<String, dynamic> json) {
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.regions != null) {
      data['regions'] = this.regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  int? id;
  String? countryId;
  String? code;
  String? defaultName;
  int? sort;

  Regions({this.id, this.countryId, this.code, this.defaultName, this.sort});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    code = json['code'];
    defaultName = json['default_name'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['code'] = this.code;
    data['default_name'] = this.defaultName;
    data['sort'] = this.sort;
    return data;
  }
}
