class ApiPath {
  static const login="/customer/login";
  static const getOTP="/user/submitphone?phone=";
  static const vertifyOTP="/user/verifyotp";
  static const profile="/customer/profile-user";
  static const lichSu='/order?per_page=10&page=';
  static const tinh="/location/region";
  static const huyen="/location/district";
  static const updatePro="/customer/profile/update";
  static const deleteAcc="/user/remove";
  static const dangky="/customer/register?refercode=";
static const firebase="/notification/fcmToken";


  /// product
static const flash='/product/flashsale?flash_sale_id=';
static const config='/config';
static const listPro='/customer/product/category/';
static const infoPro='/customer/product/info/';
static const relatePrd='/product/related?id=';
static const category='/customer/category';
static const phiVanCHuyen='/order/shipFee';
static const order="/order/create";
static const search="/product/search?keyword=";
  static const like='/product/like?product_id=';
  static const likeList="/product/favorite";
  static const rate="/product/rate";
  static const coupon="/coupon/run";
  static const testCounpon="/order/promotionCode?code=";


/// noti
static const notifi='/notification?per_page=10&page=';


/// news
  static const detailNews='/news/detail?news_id=';
static const cateNews="/news/category";
static const newsList='/news/index?category_id=';
  }