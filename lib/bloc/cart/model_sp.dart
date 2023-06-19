class ModelSanPhamMain {
  int? id;
  int? amount;
int? max;
  ModelSanPhamMain({this.id, this.amount,this.max});

  ModelSanPhamMain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount =json['gia'] ?? 0;
    max=json['max']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gia'] = this.amount;
    data['max']=this.max;
    return data;
  }
}