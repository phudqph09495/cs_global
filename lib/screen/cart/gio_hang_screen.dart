import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/model_sp.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_infoPro.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';

class GioHangScreen extends StatefulWidget {
  const GioHangScreen({Key? key}) : super(key: key);

  @override
  State<GioHangScreen> createState() => _GioHangScreenState();
}

class _GioHangScreenState extends State<GioHangScreen> {
  BlocCartLocal blocCartLocal = BlocCartLocal();

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
                'Giỏ Hàng',
                style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Giá bán: ${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.price}'))} đ',
                                              style: StyleApp.textStyle600(
                                                  color: ColorApp.dark500,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              'Lợi nhuận: 50.000 đ',
                                              style: StyleApp.textStyle600(
                                                  color: ColorApp.green00,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          BlocListener(
                                              bloc: blocCartLocal,
                                              listener: (_, StateBloc state) {
                                                if (state is LoadSuccess) {
                                                  context
                                                      .read<BlocCartLocal>()
                                                      .add(GetCart());
                                                }
                                              },
                                              child: InkWell(
                                                  onTap: () {
                                                    blocCartLocal.add(Reduce(
                                                        modelSanPhamMain:
                                                        ModelSanPhamMain(
                                                            id: list[index]
                                                                .id,
                                                            amount: 1)));
                                                  },
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: ColorApp.redText,
                                                    size: 27,
                                                  ))),
                                          Text('   ${list[index].amount}   '),
                                          BlocListener(
                                              bloc: blocCartLocal,
                                              listener: (_, StateBloc state) {
                                                if (state is LoadSuccess) {
                                                  context
                                                      .read<BlocCartLocal>()
                                                      .add(GetCart());
                                                }
                                              },
                                              child: InkWell(
                                                  onTap: () {
                                                    blocCartLocal.add(AddData(
                                                        modelSanPhamMain:
                                                            ModelSanPhamMain(
                                                                id: list[index]
                                                                    .id,
                                                                amount: 1)));
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: ColorApp.redText,
                                                    size: 27,
                                                  ))),
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
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: ColorApp.dark500, width: 1.5))),
              height: 155,
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
                          'Lợi nhuận:',
                          style: StyleApp.textStyle500(),
                        ),
                        Text(
                          '${Const.ConvertPrice.format(discount)} đ',
                          style: StyleApp.textStyle500(color: ColorApp.dark),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng số sản phẩm :',
                          style: StyleApp.textStyle500(),
                        ),
                        Text(
                          '${list.length}',
                          style: StyleApp.textStyle500(color: ColorApp.dark),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền :',
                          style: StyleApp.textStyle500(),
                        ),
                        Text(
                          '${Const.ConvertPrice.format(sum)} đ',
                          style: StyleApp.textStyle500(color: ColorApp.dark),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 20,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorApp.redText),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Mua Tiếp',
                                  style: StyleApp.textStyle500(
                                      color: ColorApp.dark500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 20,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorApp.redText),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Thanh Toán',
                                  style: StyleApp.textStyle500(
                                      color: ColorApp.whiteF0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
