import 'package:cs_global/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/gioiThieu/bloc_chitietGT.dart';
import '../../../bloc/gioiThieu/model_ctgt.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../styles/init_style.dart';
import '../../../widget/loadPage/item_loadfaild.dart';
import '../../donhang/chiTiet_screen.dart';

class ChiTietGTScreen extends StatefulWidget {
  String name;
  String id;
  ChiTietGTScreen({required this.name, required this.id});

  @override
  State<ChiTietGTScreen> createState() => _ChiTietGTScreenState();
}

class _ChiTietGTScreenState extends State<ChiTietGTScreen> {
  BlocChiTietGT blocChiTietGT = BlocChiTietGT();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocChiTietGT.add(GetData(param: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            '${widget.name}',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: blocChiTietGT,
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
              ModelChiTietGT modelChiTietGT = state.data;
              return DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                        indicatorColor: ColorApp.red,
                        unselectedLabelStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        labelColor: ColorApp.red,
                        unselectedLabelColor: ColorApp.black49,
                        tabs: [
                          Tab(text: 'Chi tiết đơn'),
                          Tab(text: 'Danh sách giới thiệu'),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          ListView.builder(

                            itemBuilder: (context, index) {
                              Color color=Colors.black;
                              switch (modelChiTietGT.orderCustomer![index].status) {
                                case 'Chờ xử lý':
                                  {
                                    color = ColorApp.yellow;

                                  }
                                  break;
                                case 'Xác nhận đơn hàng':
                                  {
                                    color = ColorApp.yellow;

                                  }
                                  break;
                                case 'Đã thanh toán nhưng chưa giao hàng':
                                  {
                                    color = ColorApp.yellow;

                                  }
                                  break;
                                case 'Trả hàng':
                                  {
                                    color = ColorApp.yellow;

                                  }
                                  break;
                                case 'Huỷ bỏ':
                                  {
                                    color = ColorApp.redText;

                                  }
                                  break;
                                case 'Hoàn thành':
                                  {
                                    color = ColorApp.green00;

                                  }
                                  break;
                              }
                              return InkWell(
                                onTap: (){
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChiTietScreen(
                                  //             totalPrice: modelChiTietGT.orderCustomer![index].totalPrice??'0',
                                  //             name: modelChiTietGT.orderCustomer![index].customerName??'',
                                  //             id: modelChiTietGT.orderCustomer![index].id.toString(),
                                  //             ship: modelChiTietGT.orderCustomer![index].shipmentPrice??'0',
                                  //             address: modelChiTietGT.orderCustomer![index].customerAddress??'',
                                  //             code: modelChiTietGT.orderCustomer![index].code??'',
                                  //             district: modelChiTietGT.orderCustomer![index].district??'',
                                  //             region: modelChiTietGT.orderCustomer![index].region??'',
                                  //             status: modelChiTietGT.orderCustomer![index].status??'',
                                  //             phone: modelChiTietGT.orderCustomer![index].customerPhone??'',
                                  //             couponPrice: modelChiTietGT.orderCustomer![index].couponPrice??'0',
                                  //             productPrice: modelChiTietGT.orderCustomer![index].totalProductPrice??'0')));
                                },
                                child: Card(
                                  color: ColorApp.whiteF0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          '${Const.convertTime('${modelChiTietGT.orderCustomer![index].createdAt}')}',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.dark500),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          'Giá trị đơn hàng : ${Const.convertPrice(modelChiTietGT.orderCustomer![index].totalPrice)} đ',
                                          style: StyleApp.textStyle700(
                                              color: ColorApp.redText),
                                        ),

                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          'Trạng thái: ${modelChiTietGT.orderCustomer![index].status}',
                                          style: StyleApp.textStyle500(
                                              color: color),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: modelChiTietGT.orderCustomer!.length,
                            physics: AlwaysScrollableScrollPhysics(),
                          ),
                          ListView.builder(

                            itemBuilder: (context, index) {
                              Color? color;
                              String name = '';
                              switch (modelChiTietGT.referCustomer![index].type) {
                                case 'thuong':
                                  {
                                    color = ColorApp.black00;
                                    name = 'Thường';
                                  }
                                  break;
                                case 'ctv':
                                  {
                                    color = ColorApp.green;
                                    name = 'Cộng tác viên';
                                  }
                                  break;
                                case 'dai_ly':
                                  {
                                    color = ColorApp.redText;
                                    name = 'Đại lý';
                                  }
                                  break;
                                case 'truong_nhom_kinh_doanh':
                                  {
                                    color = ColorApp.yellow;
                                    name = 'Trưởng Nhóm kinh doanh';
                                  }
                                  break;
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChiTietGTScreen(
                                              name:
                                              "${modelChiTietGT.referCustomer![index].name}",
                                              id: '${modelChiTietGT.referCustomer![index].id}',
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                      child: Text(
                                        '${index}.${modelChiTietGT.referCustomer![index].name} (${name})',
                                        textAlign: TextAlign.center,
                                        style: StyleApp.textStyle500(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: modelChiTietGT.referCustomer!.length,
                            physics: AlwaysScrollableScrollPhysics(),
                          ),
                        ],
                      ))
                    ],
                  ));
            }
            return Container();
          }),
    );
  }
}
