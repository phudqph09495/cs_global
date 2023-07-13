class ModelListNoti {
  List<Notify>? notify;

  ModelListNoti({this.notify});

  ModelListNoti.fromJson(Map<String, dynamic> json) {
    if (json['notify'] != null) {
      notify = <Notify>[];
      json['notify'].forEach((v) {
        notify!.add(new Notify.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notify != null) {
      data['notify'] = this.notify!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notify {
  int? id;
  String? action;
  String? title;
  String? message;
  String? status;
  int? customerId;
  int? noficationId;
  String? createdAt;
  String? updatedAt;

  Notify(
      {this.id,
        this.action,
        this.title,
        this.message,
        this.status,
        this.customerId,
        this.noficationId,
        this.createdAt,
        this.updatedAt});

  Notify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    action = json['action'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
    customerId = json['customer_id'];
    noficationId = json['nofication_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['action'] = this.action;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    data['customer_id'] = this.customerId;
    data['nofication_id'] = this.noficationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
