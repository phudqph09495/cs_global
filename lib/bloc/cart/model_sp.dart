class ModelSanPhamMain {
  int? id;
  int? amount;

  ModelSanPhamMain({this.id, this.amount});

  ModelSanPhamMain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount =json['gia'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gia'] = this.amount;
    return data;
  }
}