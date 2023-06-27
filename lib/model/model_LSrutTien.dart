class ModelLichSuGD {
  List<Histories>? histories;

  ModelLichSuGD({this.histories});

  ModelLichSuGD.fromJson(Map<String, dynamic> json) {
    if (json['histories'] != null) {
      histories = <Histories>[];
      json['histories'].forEach((v) {
        histories!.add(new Histories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.histories != null) {
      data['histories'] = this.histories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Histories {
  int? id;
  int? customerId;
  String? type;
  String? bankName;
  String? bankAccount;
  String? bankCode;
  String? accountName;
  String? price;
  String? image;
  String? status;
  String? note;
  String? createdAt;
  String? updatedAt;

  Histories(
      {this.id,
        this.customerId,
        this.type,
        this.bankName,
        this.bankAccount,
        this.bankCode,
        this.accountName,
        this.price,
        this.image,
        this.status,
        this.note,
        this.createdAt,
        this.updatedAt});

  Histories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    type = json['type'];
    bankName = json['bank_name'];
    bankAccount = json['bank_account'];
    bankCode = json['bank_code'];
    accountName = json['account_name'];
    price = json['price'];
    image = json['image'];
    status = json['status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['type'] = this.type;
    data['bank_name'] = this.bankName;
    data['bank_account'] = this.bankAccount;
    data['bank_code'] = this.bankCode;
    data['account_name'] = this.accountName;
    data['price'] = this.price;
    data['image'] = this.image;
    data['status'] = this.status;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
