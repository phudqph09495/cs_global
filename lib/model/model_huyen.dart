class ModelHuyen {
  List<Districts>? districts;

  ModelHuyen({this.districts});

  ModelHuyen.fromJson(Map<String, dynamic> json) {
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  int? id;
  int? regionId;
  String? code;
  String? defaultName;
  int? internal;
  String? countryId;
  int? sort;

  Districts(
      {this.id,
        this.regionId,
        this.code,
        this.defaultName,
        this.internal,
        this.countryId,
        this.sort});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    code = json['code'];
    defaultName = json['default_name'];
    internal = json['internal'];
    countryId = json['country_id'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['code'] = this.code;
    data['default_name'] = this.defaultName;
    data['internal'] = this.internal;
    data['country_id'] = this.countryId;
    data['sort'] = this.sort;
    return data;
  }
}
