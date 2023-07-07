import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/home.dart';
import 'package:cs_global/model/model_listDonHang.dart';
import 'package:cs_global/screen/auth/auth_screen.dart';
import 'package:cs_global/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../bloc/donHang/bloc_listDOnHang.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import 'chiTiet_screen.dart';

class QuanLyScreen extends StatefulWidget {
  const QuanLyScreen({Key? key}) : super(key: key);

  @override
  State<QuanLyScreen> createState() => _QuanLyScreenState();
}

class _QuanLyScreenState extends State<QuanLyScreen> {
  final controller = GroupButtonController();
  List<String> name = ['Đơn Hàng Mới', 'Đơn Đã Đặt', 'Đơn Đã Mua','Đơn Bị Huỷ'];
  int ind = 0;
  List<Color> colorName = [Colors.red, ColorApp.orangeF0, ColorApp.green00];
  BlocListDonhang blocListDonhang = BlocListDonhang();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectIndex(0);
    blocListDonhang.add(GetData(param: 'new'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
       Container(
         height: 70,
         child: ListView(

           scrollDirection: Axis.horizontal,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: GroupButton(
                   controller: controller,
                   isRadio: true,
                   onSelected: (index, isSelected, bool) {
                     ind = isSelected;

                     setState(() {});
                     switch (isSelected) {
                       case 0:
                         {
                           blocListDonhang.add(GetData(param: 'new'));
                         }
                         break;
                       case 1:
                         {
                           blocListDonhang.add(GetData(param: 'waiting'));
                         }
                         break;
                       case 2:
                         {
                           blocListDonhang.add(GetData(param: 'done'));
                         }
                         break;
                       case 3:
                         {
                           blocListDonhang.add(GetData(param: 'denied'));
                         }
                         break;
                     }
                   },
                   buttons: List.generate(name.length, (i) => '${name[i]}'),
                   options: GroupButtonOptions(


                       unselectedBorderColor: ColorApp.green00,
                       selectedTextStyle:
                       StyleApp.textStyle500(color: Colors.white),
                       selectedColor: ColorApp.green00,
                       unselectedTextStyle:
                       StyleApp.textStyle500(color: ColorApp.green00),
                       borderRadius: BorderRadius.circular(20),
                       spacing: (MediaQuery.of(context).size.width ) * 0.02,
                       buttonWidth:
                       (MediaQuery.of(context).size.width ) * 0.32)),
             ),
           ],
         ),
       ),
          Container(
            height: 5,
            color: ColorApp.greyBD.withOpacity(0.7),
            width: double.infinity,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder(
                      builder: (context, StateBloc state) {
                        if (state is Loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorApp.main,
                            ),
                          );
                        }
                        if (state is LoadSuccess) {
                          ModelListDonHang model = state.data;
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChiTietScreen(
                                              totalPrice: model.orders![index].totalPrice??'0',
                                              name: model.orders![index].customerName??'',
                                              id: model.orders![index].id.toString(),
                                              ship: model.orders![index].shipmentPrice??'0',
                                              address: model.orders![index].customerAddress??'',
                                              code: model.orders![index].code??'',
                                              district: model.orders![index].district??'',
                                              region: model.orders![index].region??'',
                                              status: model.orders![index].status??'',
                                              phone: model.orders![index].customerPhone??'',
                                              couponPrice: model.orders![index].couponPrice??'0',
                                              productPrice: model.orders![index].totalProductPrice??'0')));
                                },
                                child: Card(
                                  color: ColorApp.whiteF0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name[ind],
                                          style: StyleApp.textStyle500(
                                              color: colorName[ind]),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          '${Const.convertTime('${model.orders![index].createdAt}')}',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.dark500),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${Const.convertPrice(model.orders![index].totalPrice)} đ',
                                              style: StyleApp.textStyle700(
                                                  color: ColorApp.redText),
                                            ),
                                            Text(
                                              'Xem chi tiết',
                                              style: StyleApp.textStyle500(
                                                  color: ColorApp.dark500,
                                                  decoration:
                                                      TextDecoration.underline),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: model.orders!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          );
                        }
                        if (state is LoadFail) {
                    return      Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.error,
                                  style: StyleApp.textStyle400(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));

                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: const BorderSide(color: ColorApp.main, width: 1))),
                                  child: Text(
                                    'Đăng nhập',
                                    style: StyleApp.textStyle400(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      },
                      bloc: blocListDonhang,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Quản lý đơn hàng',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
