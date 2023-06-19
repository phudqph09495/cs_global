class ModelShip {
  int? cost;

  ModelShip({this.cost});

  ModelShip.fromJson(Map<String, dynamic> json) {
    cost =json['cost'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    return data;
  }
}
