class ModelListBank {
  String? code;
  String? desc;
  List<Bank>? data;

  ModelListBank({this.code, this.desc, this.data});

  ModelListBank.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    desc = json['desc'];
    if (json['data'] != null) {
      data = <Bank>[];
      json['data'].forEach((v) {
        data!.add(new Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['desc'] = this.desc;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  int? id;
  String? name;
  String? code;
  String? bin;
  String? shortName;
  String? logo;
  int? transferSupported;
  int? lookupSupported;

  int? support;
  int? isTransfer;
  String? swiftCode;

  Bank(
      {this.id,
        this.name,
        this.code,
        this.bin,
        this.shortName,
        this.logo,
        this.transferSupported,
        this.lookupSupported,

        this.support,
        this.isTransfer,
        this.swiftCode});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    bin = json['bin'];
    shortName = json['shortName'];
    logo = json['logo'];
    transferSupported = json['transferSupported'];
    lookupSupported = json['lookupSupported'];

    support = json['support'];
    isTransfer = json['isTransfer'];
    swiftCode = json['swift_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['bin'] = this.bin;
    data['shortName'] = this.shortName;
    data['logo'] = this.logo;
    data['transferSupported'] = this.transferSupported;
    data['lookupSupported'] = this.lookupSupported;
    data['short_name'] = this.shortName;
    data['support'] = this.support;
    data['isTransfer'] = this.isTransfer;
    data['swift_code'] = this.swiftCode;
    return data;
  }
}
