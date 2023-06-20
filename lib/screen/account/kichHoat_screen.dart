import 'package:cs_global/model/model_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import 'chuyenKhoan_screen.dart';

class KichHoatScreen extends StatefulWidget {
  String mota;
  String type;
  KichHoatScreen({required this.mota,required this.type});

  @override
  State<KichHoatScreen> createState() => _KichHoatScreenState();
}

class _KichHoatScreenState extends State<KichHoatScreen> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.type);
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
        bloc: blocProfile,
        builder: (_, StateBloc state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorApp.main,
              ),
            );
          }
          if (state is LoadFail) {
            return ItemLoadFaild(
              error: state.error,
              onTap: () {},
            );
          }
          if (state is LoadSuccess) {
            ModelProfile model = state.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: ColorApp.green00,
                title: Text(
                  'Kích hoạt quyền kinh doanh',
                  style:
                      StyleApp.textStyle500(fontSize: 20, color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Kích hoạt quyền kinh doanh',
                      style: StyleApp.textStyle500(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.mota,
                      style: StyleApp.textStyle500(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Const.showScreen(
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: StatefulBuilder(
                                    builder: (context, StateSetter setState1) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Chọn phương thức thanh toán',
                                                style: StyleApp.textStyle500(
                                                    fontSize: 16),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon((Icons.clear)))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            color: ColorApp.whiteF0,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/vnpay.png',
                                                    width: 30,
                                                  ),    SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Thanh toán qua VNPay',
                                                    style:
                                                        StyleApp.textStyle600(
                                                            fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            color: ColorApp.whiteF0,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cslogo.png',
                                                    width: 30,
                                                  ),    SizedBox(
                                                    width: 5,
                                                  ),
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
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChuyenKhoanScreen(type: widget.type,)));
                                            },
                                            child: Container(
                                              color: ColorApp.whiteF0,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.bank,
                                                      size: 20,
                                                      color: ColorApp.green00,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Thanh toán chuyển khoản',
                                                      style:
                                                          StyleApp.textStyle600(
                                                              fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
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
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorApp.green00,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Xác nhận',
                            style: StyleApp.textStyle500(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold();
        });
  }
}
