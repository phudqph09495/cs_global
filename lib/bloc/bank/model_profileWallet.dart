class ModelProfileWallet {
  WalletProfile? walletProfile;

  ModelProfileWallet({this.walletProfile});

  ModelProfileWallet.fromJson(Map<String, dynamic> json) {
    walletProfile = json['walletProfile'] != null
        ? new WalletProfile.fromJson(json['walletProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.walletProfile != null) {
      data['walletProfile'] = this.walletProfile!.toJson();
    }
    return data;
  }
}

class WalletProfile {
  int? id;
  String? code;
  String? avatar;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? bankName;
  String? bankCode;
  String? bankAccount;
  String? banner;
  String? account_name;
  Null? slogan;
  int? score;
  String? balance;
  String? totalCost;
  String? manageFee;
  Type? type;
  String? status;
  StatusBank? statusBank;

  WalletProfile(
      {this.id,
        this.code,
        this.avatar,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.account_name,
        this.bankName,
        this.bankCode,
        this.bankAccount,
        this.banner,
        this.slogan,
        this.score,
        this.balance,
        this.totalCost,
        this.manageFee,
        this.type,
        this.status,
        this.statusBank});

  WalletProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    avatar = json['avatar'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    bankAccount = json['bank_account'];
    banner = json['banner'];
    slogan = json['slogan'];
    score = json['score'];
    account_name=json['account_name'];
    balance = json['balance'];
    totalCost = json['total_cost'];
    manageFee = json['manage_fee'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    status = json['status'];
    statusBank = json['status_bank'] != null
        ? new StatusBank.fromJson(json['status_bank'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['bank_account'] = this.bankAccount;
    data['banner'] = this.banner;
    data['slogan'] = this.slogan;
    data['score'] = this.score;
    data['balance'] = this.balance;
    data['total_cost'] = this.totalCost;
    data['manage_fee'] = this.manageFee;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['status'] = this.status;
    if (this.statusBank != null) {
      data['status_bank'] = this.statusBank!.toJson();
    }
    return data;
  }
}

class Type {
  String? key;
  String? name;

  Type({this.key, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}

class StatusBank {
  bool? key;
  String? name;

  StatusBank({this.key, this.name});

  StatusBank.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}
