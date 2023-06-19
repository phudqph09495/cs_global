import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/bloc/order/bloc_addCoupon.dart';
import 'package:cs_global/bloc/order/bloc_huyen.dart';
import 'package:cs_global/bloc/order/bloc_phiShip.dart';
import 'package:cs_global/bloc/order/bloc_tinh.dart';
import 'package:cs_global/home.dart';
import 'package:cs_global/model/model_huyen.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:cs_global/model/model_ship.dart';
import 'package:cs_global/widget/item/custom_toast.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/bloc_order.dart';
import '../../bloc/cart/model_sp.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_tinh.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../auth/otp_modal.dart';

class ThanhToanScreen extends StatefulWidget {
  const ThanhToanScreen({Key? key}) : super(key: key);

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  String tinhS = 'Chọn tỉnh/TP';
  String huyenS = 'Chọn quận/huyện';
  BlocTinh blocTinh = BlocTinh()..add(GetData());
  String idTinh = '';
  String idHuyen = '';
  BlocHuyen blocHuyen = BlocHuyen();
  BlocPhiShip blocPhiShip = BlocPhiShip();
  TextEditingController address = TextEditingController();
  BlocAddCoupon blocAddCoupon = BlocAddCoupon();
  Coupon coupon=Coupon();
  int ship = 0;
  int voucherINT = 0;
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  BlocOrder blocOrder = BlocOrder();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCartLocal, StateBloc>(
      builder: (context, StateBloc state) {
        if (state is Loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: ColorApp.main,
              ),
            ),
          );
        }

        if (state is LoadSuccess) {
          List<ModelSanPhamMain> list = state.data;
          int sum = state.data2;
          List<ModelInfoPro> listInfo = state.data3;
          int discount = state.data4;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: ColorApp.green00,
              title: Text(
                'Thanh Toán',
                style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder(
                    builder: (_, StateBloc statePro) {
                      if (statePro is LoadFail) {
                        Future.delayed(Duration(seconds: 1), () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    statePro.error,
                                    style: StyleApp.textStyle500(),
                                  ),
                                  actions: [
                                    InkWell(
                                      onTap: () async {
                                        await SharePrefsKeys.removeAllKey();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StartScreen()));
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          decoration:
                                          BoxDecoration(color: Colors.green),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Quay lại trang đăng nhập',
                                              textAlign: TextAlign.center,
                                              style: StyleApp.textStyle500(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    )
                                  ],
                                );
                              });
                          // await SharePrefsKeys.removeAllKey();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => StartScreen()));
                        });
                        return SizedBox();
                      }
                      return SizedBox();
                    },
                    bloc: blocProfile,
                  ),
                  Card(
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(5),
                          },
                          border: TableBorder(
                              horizontalInside:
                                  BorderSide(color: Colors.black12),
                              top: BorderSide(color: Colors.black12),
                              left: BorderSide(color: Colors.black12),
                              right: BorderSide(color: Colors.black12),
                              bottom: BorderSide(color: Colors.black12)),
                          children: [
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Thông tin giao hàng',
                                          style: StyleApp.textStyle700()),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('',
                                          style: TextStyle(fontSize: 20.0)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tỉnh/thành phố',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BlocBuilder(
                                      builder: (_, StateBloc stateTinh) {
                                        if (stateTinh is LoadSuccess) {
                                          ModelTinh modelTinh = stateTinh.data;
                                          return PopupMenuButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(),
                                                  Row(
                                                    children: [
                                                      Text('${tinhS}'),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              itemBuilder: (context) {
                                                return List.generate(
                                                    modelTinh.regions!.length,
                                                    (index) => PopupMenuItem(
                                                          value: index,
                                                          onTap: () {
                                                            setState(() {
                                                              tinhS =
                                                                  '${modelTinh.regions![index].defaultName}';
                                                              idTinh = modelTinh
                                                                  .regions![
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                              blocHuyen.add(GetData(
                                                                  param:
                                                                      '${modelTinh.regions![index].id}'));
                                                              huyenS = '';
                                                              idHuyen = '';
                                                              blocPhiShip.add(
                                                                  GetData());
                                                              ship = 0;
                                                            });
                                                            print(idTinh);
                                                            print(idHuyen);
                                                          },
                                                          child: Text(
                                                            '${modelTinh.regions![index].defaultName}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ));
                                              });
                                        }
                                        return SizedBox();
                                      },
                                      bloc: blocTinh,
                                    )
                                    //
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Quận/huyện',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BlocBuilder(
                                      builder: (_, StateBloc stateHuyen) {
                                        if (stateHuyen is LoadSuccess) {
                                          ModelHuyen modelHuyen =
                                              stateHuyen.data;
                                          return PopupMenuButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(),
                                                  Row(
                                                    children: [
                                                      Text('${huyenS}'),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              itemBuilder: (context) {
                                                return List.generate(
                                                    modelHuyen
                                                        .districts!.length,
                                                    (index) => PopupMenuItem(
                                                          value: index,
                                                          onTap: () {
                                                            setState(() {
                                                              huyenS =
                                                                  '${modelHuyen.districts![index].defaultName}';
                                                              idHuyen = modelHuyen
                                                                  .districts![
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                            });

                                                            blocPhiShip.add(
                                                                GetData(
                                                                    huyen:
                                                                        idHuyen,
                                                                    tinh:
                                                                        idTinh));
                                                          },
                                                          child: BlocListener(
                                                            bloc: blocPhiShip,
                                                            listener: (_,
                                                                StateBloc
                                                                    state0) {
                                                              if (state0
                                                                  is LoadSuccess) {
                                                                ModelShip
                                                                    model =
                                                                    state0.data;
                                                                ship = model
                                                                        .cost ??
                                                                    0;
                                                              }
                                                            },
                                                            child: Text(
                                                              '${modelHuyen.districts![index].defaultName}',
                                                              style: StyleApp
                                                                  .textStyle500(),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ));
                                              });
                                        }
                                        return SizedBox();
                                      },
                                      bloc: blocHuyen,
                                    )
                                    //
                                  ]),
                            ]),
                          ],
                        ),
                        Table(
                          border: TableBorder(
                              bottom: BorderSide(color: Colors.black12),
                              left: BorderSide(color: Colors.black12),
                              right: BorderSide(color: Colors.black12)),
                          columnWidths: const {
                            0: FlexColumnWidth(50),
                            1: FlexColumnWidth(1),
                          },
                          children: [
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Địa chỉ cụ thể',
                                            style: StyleApp.textStyle400(),
                                          ),
                                          Text(
                                            'Số nhà, tên toà nhà, tên đường tên khu vực',
                                            style: StyleApp.textStyle400(
                                                fontSize: 12),
                                          ),
                                          TextFormField(
                                            controller: address,
                                            decoration: InputDecoration(
                                              hintText: 'Nhập địa chỉ cụ thế',
                                              hintStyle:
                                                  StyleApp.textStyle400(),
                                            ),
                                            maxLines: 1,
                                            onChanged: (val) {},
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('',
                                          style: StyleApp.textStyle400()),
                                    )
                                  ]),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/voucher.png'),
                            Text(
                              '   Chọn mã giảm giá',
                              style: StyleApp.textStyle600(fontSize: 16),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              TextEditingController voucher =
                                  TextEditingController();
                              Const.showScreen(
                                  Container(
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InputText1(
                                            label: 'Nhập mã giảm giá',
                                            controller: voucher,
                                          ),
                                          BlocListener(
                                            bloc: blocAddCoupon,
                                            listener: (_, StateBloc state) {
                                              CheckLogState.check(context,
                                                  state: state,
                                                  msg: 'Thêm code thành công',
                                                  success: () {
                                                coupon = state is LoadSuccess
                                                    ? state.data
                                                    : Coupon();

                                                voucherINT = int.parse(
                                                    coupon!.price ?? '0');
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                blocAddCoupon.add(GetData(
                                                    param: voucher.text,
                                                    type: sum.toString()));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: ColorApp.green00,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Thêm',
                                                    style:
                                                        StyleApp.textStyle500(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  context,
                                  color: Colors.white);
                            },
                            child: Text(
                              'Chọn',
                              style: StyleApp.textStyle600(
                                  fontSize: 16, color: ColorApp.blue8F),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/bill.png'),
                            Text(
                              '   Phương thức thanh toán',
                              style: StyleApp.textStyle600(fontSize: 16),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            int checked = -1;
                            Const.showScreen(
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: StatefulBuilder(
                                        builder:
                                            (context, StateSetter setState1) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Chọn phương thức thanh toán',
                                                    style:
                                                        StyleApp.textStyle500(
                                                            fontSize: 16),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Icon((Icons.clear)))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/vnpay.png'),
                                                  Text(
                                                    'Thanh toán qua VNPay',
                                                    style:
                                                        StyleApp.textStyle600(
                                                            fontSize: 16),
                                                  ),
                                                  Radio(
                                                      activeColor:
                                                          ColorApp.green00,
                                                      value: 0,
                                                      groupValue: checked,
                                                      onChanged: (val) {
                                                        setState1(() {
                                                          checked = val!;
                                                        });
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/cslogo.png'),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Thanh toán qua ví CS',
                                                        style: StyleApp
                                                            .textStyle600(
                                                                fontSize: 16),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Số dư ví(VNĐ): ',
                                                            style: StyleApp
                                                                .textStyle600(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          BlocBuilder(
                                                            builder: (_,
                                                                StateBloc
                                                                    state) {
                                                              ModelProfile
                                                                  model =
                                                                  state is LoadSuccess
                                                                      ? state
                                                                          .data
                                                                      : ModelProfile();
                                                              return Text(
                                                                ' ${Const.convertPrice(model.profile!.balance)} đ',
                                                                style: StyleApp
                                                                    .textStyle600(
                                                                        fontSize:
                                                                            16),
                                                              );
                                                            },
                                                            bloc: blocProfile,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Radio(
                                                      activeColor:
                                                          ColorApp.green00,
                                                      value: 1,
                                                      groupValue: checked,
                                                      onChanged: (val) {
                                                        setState1(() {
                                                          checked = val!;
                                                        });
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/cod.png'),
                                                  Text(
                                                    'Thanh toán  COD',
                                                    style:
                                                        StyleApp.textStyle600(
                                                            fontSize: 16),
                                                  ),
                                                  Radio(
                                                      activeColor:
                                                          ColorApp.green00,
                                                      value: 2,
                                                      groupValue: checked,
                                                      onChanged: (val) {
                                                        setState1(() {
                                                          checked = val!;
                                                        });
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 35,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: ColorApp.green00,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    'CẬP NHẬT',
                                                    style:
                                                        StyleApp.textStyle600(
                                                            color: ColorApp
                                                                .whiteF7,
                                                            fontSize: 18),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                context,
                                color: Colors.white,
                                sign: false);
                          },
                          child: Text(
                            'Chọn',
                            style: StyleApp.textStyle600(
                                fontSize: 16, color: ColorApp.blue8F),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: LoadImage(
                                url:
                                    '${Const.image_host}${listInfo[index].product!.thumbnail}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        '${listInfo[index].product!.name}',
                                        style: StyleApp.textStyle700(),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.discountPrice}'))} đ x ${list[index].amount}',
                                        style: StyleApp.textStyle600(
                                            color: ColorApp.dark500,
                                            fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '   ${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.discountPrice}') * list[index].amount!)}  đ  '),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listInfo.length,
                  ),
                  SizedBox(
                    height: 155,
                  )
                  // ...List.generate(list.length, (index) => Text(
                  //    '${list[index].id} - ${list[index].amount}',
                  //    style: StyleApp.textStyle500(
                  //        fontSize: 20, color: Colors.red),
                  //  ))
                ],
              ),
            ),
            bottomSheet: Container(
              height: 175,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: ColorApp.dark500, width: 1.5))),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 15, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tiền sản phẩm :',
                          style: StyleApp.textStyle500(),
                        ),
                        Text(
                          '${Const.ConvertPrice.format(sum)} đ',
                          style: StyleApp.textStyle500(color: ColorApp.dark),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phí ship:',
                          style: StyleApp.textStyle500(),
                        ),
                        BlocBuilder(
                          builder: (_, StateBloc stateShip) {
                            if (stateShip is LoadSuccess) {
                              ModelShip fee = stateShip.data;

                              return Text(
                                '${Const.ConvertPrice.format(fee.cost)} đ',
                                style:
                                    StyleApp.textStyle500(color: ColorApp.dark),
                              );
                            }
                            return SizedBox();
                          },
                          bloc: blocPhiShip,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mã giảm giá:',
                          style: StyleApp.textStyle500(),
                        ),
                        BlocBuilder(
                          builder: (_, StateBloc stateVoucher) {
                            if (stateVoucher is LoadSuccess) {
                              Coupon fee = stateVoucher.data;
                              return Text(
                                '- ${Const.ConvertPrice.format(int.parse('${fee.price}'))} đ',
                                style:
                                    StyleApp.textStyle500(color: ColorApp.dark),
                              );
                            }
                            return SizedBox();
                          },
                          bloc: blocAddCoupon,
                        ),
                      ],
                    ),
                    BlocBuilder(
                      builder: (_, StateBloc state1) {
                        return BlocBuilder(
                          builder: (_, StateBloc state2) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng :',
                                  style: StyleApp.textStyle500(),
                                ),
                                Text(
                                  '${Const.ConvertPrice.format(sum + ship - voucherINT)} đ',
                                  style: StyleApp.textStyle700(
                                      color: ColorApp.dark),
                                )
                              ],
                            );
                          },
                          bloc: blocAddCoupon,
                        );
                      },
                      bloc: blocPhiShip,
                    ),
                    BlocListener(
                      bloc: blocOrder,
                      listener: (_, StateBloc stateOrder) {
                        CheckLogState.check(context,
                            state: stateOrder,
                            msg: 'Đặt hàng thành công',
                            success: () {
                              context
                                  .read<BlocCartLocal>()
                                  .add(ClearAll());
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            });
                      },
                      child: InkWell(
                        onTap: () {
                          int gia=sum + ship - voucherINT;
                          List<Products> products = [];
                          if (tinhS == 'Chọn tỉnh/TP' ||
                              huyenS == 'Chọn quận/huyện' ||
                              address.text == '') {
                            CustomToast.showToast(
                                context: context,
                                msg: 'Hãy nhập đầy đủ địa chỉ');
                          } else {
                            for (var i = 0; i < list.length; i++) {
                              products.add(Products(
                                  quanty: list[i].amount,
                                  price: int.parse(
                                      listInfo[i].product!.discountPrice ??
                                          '0'),
                                  productInfo: listInfo[i].product));
                            }
                            blocOrder.add(CreateOrder(
                                region: tinhS,
                                coupon: coupon,
                                district: huyenS,
                                address: address.text,
                                products: products,
                                shipmentCost: ship,
                                totalProductPrice: sum,
                                freeShip: 'false',
                                totalPrice: gia));

                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorApp.redText),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Thanh Toán',
                              style: StyleApp.textStyle500(
                                  fontSize: 14, color: ColorApp.whiteF0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
