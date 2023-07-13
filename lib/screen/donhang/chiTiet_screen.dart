import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/model/model_detailOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/donHang/bloc_detailOrder.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/order/bloc_cancelOrder.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';

class ChiTietScreen extends StatefulWidget {
  String id;
  ChiTietScreen(
      {
      required this.id,
 });

  @override
  State<ChiTietScreen> createState() => _ChiTietScreenState();
}

class _ChiTietScreenState extends State<ChiTietScreen> {
  BlocDetailOrder blocDetailOrder = BlocDetailOrder();
  BlocCancelOrder blocCancelOrder=BlocCancelOrder();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocDetailOrder.add(GetData(param: widget.id));
  }

  @override
  Widget build(BuildContext context) {
  return BlocBuilder(builder: (_,StateBloc state){
    if(state is LoadSuccess){
      ModelOrderDetail model = state.data;
      return Scaffold(
        bottomSheet: Container(
          height: 135,
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
                      '${Const.convertPrice(model.order!.totalProductPrice)} đ',
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
                    Text(
                      '${Const.convertPrice(model.order!.shipmentPrice)} đ',
                      style:
                      StyleApp.textStyle500(color: ColorApp.dark),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mã giảm giá:',
                      style: StyleApp.textStyle500(),
                    ),
                    Text(
                      '- ${Const.convertPrice(model.order!.couponPrice)} đ',
                      style:
                      StyleApp.textStyle500(color: ColorApp.dark),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng :',
                      style: StyleApp.textStyle500(),
                    ),
                    Text(
                      '${Const.convertPrice(model.order!.totalPrice)} đ',
                      style: StyleApp.textStyle700(
                          color: ColorApp.dark),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          actions: [
            BlocListener(
              bloc: blocCancelOrder,
              listener: (_,StateBloc state) {
                CheckLogState.check(context, state: state,msg: 'Huỷ thành công',success: (){
                  blocDetailOrder.add(GetData(param: widget.id));

                });
              },
              child: InkWell(
                onTap: (){
                  blocCancelOrder.add(GetData(param: widget.id));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(child: Text('Huỷ Đơn',style: StyleApp.textStyle700(color: ColorApp.redText,fontSize: 16),)),
                ),
              ),
            ),
          ],
          backgroundColor: ColorApp.green00,
          title: Text(
            'Chi Tiết Đơn Hàng',
            style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trạng thái: ',
                      style: StyleApp.textStyle700(),
                    ),
                    Text(
                      model.order!.status??'',
                      style: StyleApp.textStyle500(),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorApp.greyBD,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã đơn hàng',
                          style: StyleApp.textStyle700(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.order!.code??'',
                          style: StyleApp.textStyle500(),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Loại đơn: ${model.order!.type=='khach_hang'?'Mua cho khách hàng':'Mua cho bản thân'}',
                          style: StyleApp.textStyle500(),
                        ),   SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Thông tin giao hàng',
                          style: StyleApp.textStyle700(fontSize: 16),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Khách hàng: ${model.order!.type=='khach_hang'?'${model.order!.receiverName}':'${model.order!.customerName}'}',
                          style: StyleApp.textStyle700(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Địa chỉ: ${model.order!.customerAddress} - ${model.order!.district} - ${model.order!.region}',
                          style: StyleApp.textStyle700(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model.order!.type=='khach_hang'?'${model.order!.receiverPhone}':'${model.order!.customerPhone}'}',
                          style: StyleApp.textStyle700(),
                        ),
                        // Text(
                        //   widget.name,
                        //   style: StyleApp.textStyle500(),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   '${widget.address} - ${widget.district} - ${widget.region} ',
                        //   style: StyleApp.textStyle500(),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   widget.phone,
                        //   style: StyleApp.textStyle500(),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Thời gian giao hàng',
                        //   style: StyleApp.textStyle700(fontSize: 16),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   '',
                        //   style: StyleApp.textStyle500(),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          'Phương thức giao hàng',
                          style: StyleApp.textStyle700(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'COD',
                          style: StyleApp.textStyle500(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Sản phẩm của bạn',
                  style: StyleApp.textStyle700(color: ColorApp.dark),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder(
                  builder: (_, StateBloc state) {
                    if (state is LoadSuccess) {
                      ModelOrderDetail model = state.data;
                      return ListView.builder(
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
                                    '${Const.image_host}${model.orderDetail![index].productImg}',
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
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                          child: Text(
                                            '${model.orderDetail![index].productName}',
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
                                            '${Const.ConvertPrice.format(int.parse('${model.orderDetail![index].price}'))} đ x ${model.orderDetail![index].amount}',
                                            style: StyleApp.textStyle600(
                                                color: ColorApp.dark500,
                                                fontSize: 14),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '   ${Const.ConvertPrice.format(int.parse('${model.orderDetail![index].price}') * model.orderDetail![index].amount!)}  đ  ',
                                                style: StyleApp.textStyle600(
                                                    color: ColorApp.dark500,
                                                    fontSize: 14),
                                              ),
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
                        itemCount: model.orderDetail!.length,
                      );
                    }
                    return SizedBox();
                  },
                  bloc: blocDetailOrder,
                ),
                SizedBox(
                  height: 155,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold();
  },bloc: blocDetailOrder,);
  }
}
