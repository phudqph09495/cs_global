abstract class EventBloc {}

class LoadMoreEvent extends EventBloc {
  String id;
  int limit, page;
  bool cleanList, loadMore;
  String? sort;

  LoadMoreEvent(
      {this.id = '',
      this.cleanList = false,
      this.limit = 0,
      this.page = 1,
      this.loadMore = false,
      this.sort});
}

class UpdateProfile extends EventBloc {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? avatar;
  String? banner;
  String? birth;
  String? id;
  String? nameS;
  UpdateProfile(
      {this.phone,
      this.name,
      this.email,
      this.address,
      this.banner,
      this.avatar,
      this.birth,
      this.id,
      this.nameS});
}

class GetData extends EventBloc {
  int limit, page;
  bool cleanList, loadMore;
  String param;
  String type;
  String year;
  String tinh;
  String huyen;

  String month;

  GetData(
      {this.cleanList = false,
      this.limit = 20,
      this.page = 1,
      this.loadMore = false,
      this.param = '',
      this.type = '',
      this.year = '',
      this.month = '',
      this.tinh = '',
      this.huyen = ''});
}

class GetData2 extends EventBloc {
  String param;
  GetData2({this.param = ''});
}

class PhiVC extends EventBloc {
  String region;
  String district;
  PhiVC({this.region = '', this.district = ''});
}

class LoginApp extends EventBloc {
  String userName;
  String password;

  LoginApp({
    required this.userName,
    required this.password,
  });
}
class Comment extends EventBloc {
  int? productID;
  int? star;
  String? comment;


  Comment({
   this.star,this.comment,this.productID
  });
}

class upgrade extends EventBloc {
  String? type;
  String? img;

  upgrade({
    this.type,
    this.img,
  });
}

class changePass extends EventBloc {
  String? phone;
  String? currentPassword;
  String? newPassword;
  String? rePassword;
  String? otp;

  changePass({
    this.phone,
    this.currentPassword,
    this.newPassword,
    this.rePassword,
    this.otp,
  });
}

class getOTP extends EventBloc{
  String phone;
  String type;
  getOTP({this.phone='',this.type=''});
}
class napTien extends EventBloc {
  int? price;
  String? img;
  String? code;

  napTien({
    this.price,
    this.img,
    this.code
  });
}

class CreateAcc extends EventBloc {
  String? name;
  String? phone;
  String? pass;
  String? rePass;
  String code;
  String? otp;
  CreateAcc({this.pass, this.rePass, this.code = '', this.name, this.phone,this.otp});
}

class RatePrd extends EventBloc {
  String? product_id;
  int? star;
  String? content;
  RatePrd({this.content, this.star, this.product_id});
}

class DangKy extends EventBloc {
  String phone;
  String password;
  String password_confirmation;

  DangKy({
    required this.password_confirmation,
    required this.phone,
    required this.password,
  });
}

class DuyetDon extends EventBloc {
  int? id;
  String? status;
  String param;
  DuyetDon({this.id, this.status, this.param = ''});
}

class GetData3 extends EventBloc {
  String param;
  String type;
  GetData3({this.type = '', this.param = ''});
}

class Delivery_info extends EventBloc {
  String? address;
  String? region_id;
  String? district_id;
  String? name;
  String? phone;
  Delivery_info(
      {this.name, this.address, this.phone, this.district_id, this.region_id});
}

class UpdateBank extends EventBloc {
  String? bankName;
  String? bankCode;
  String? bankAcc;
  String? bankAccName;

  UpdateBank(this.bankName, this.bankCode, this.bankAcc,this.bankAccName);


}
