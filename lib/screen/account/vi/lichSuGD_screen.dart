import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/model/model_LSrutTien.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bank/bloc_lsGD.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../styles/init_style.dart';
import '../../../widget/loadPage/item_loadfaild.dart';

class LichSuGD extends StatefulWidget {
  const LichSuGD({super.key});

  @override
  State<LichSuGD> createState() => _LichSuGDState();
}

class _LichSuGDState extends State<LichSuGD> {
  BlocLSGD blocLSGD = BlocLSGD();
  Future<void> refresh() async {
    blocLSGD.add(GetData());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Lịch sử giao dịch ',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder(
                  bloc: blocLSGD,
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
                        onTap: () {
                          blocLSGD.add(GetData());
                        },
                      );
                    }
                    if (state is LoadSuccess) {
                      ModelLichSuGD model = state.data;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          String type = '';
                          String typeS = '';
                          Color color = Colors.black;

                          switch (model.histories![index].type) {
                            case 'nap_tien':
                              {
                                typeS = 'n';
                                type = 'Nạp Tiền';
                                color = ColorApp.green00;
                              }
                              break;
                            case 'rut_tien':
                              {
                                typeS = 'r';
                                type = 'Rút Tiền';
                                color = ColorApp.redText;
                              }
                              break;
                          }

                          Color colorTT = Colors.black;
                          switch (model.histories![index].status) {
                            case 'Chờ duyệt':
                              {
                                colorTT = ColorApp.yellow;
                              }
                              break;
                            case 'Đã duyệt':
                              {
                                colorTT = ColorApp.green;
                              }
                              break;
                            case 'Hủy':
                              {
                                colorTT = ColorApp.redText;
                              }
                              break;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (typeS == 'r') {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                              'Thông tin ngân hàng',
                                              style: StyleApp.textStyle500(),
                                            ),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Ngân hàng : ${model.histories![index].bankName}',
                                                    style:
                                                        StyleApp.textStyle500(),
                                                  ),
                                                  Text(
                                                    'Số tài khoản : ${model.histories![index].bankAccount}',
                                                    style:
                                                        StyleApp.textStyle500(),
                                                  ),
                                                  Text(
                                                    'Tên chủ tài khoản: ${model.histories![index].accountName}',
                                                    style:
                                                        StyleApp.textStyle500(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                }
                              },
                              child: Card(
                                color: ColorApp.whiteF0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${type}',
                                            style: StyleApp.textStyle600(
                                                fontSize: 16, color: color),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                typeS == 'n' ? '+' : '-',
                                                style: StyleApp.textStyle600(
                                                    fontSize: 15, color: color),
                                              ),
                                              Text(
                                                ' ${Const.convertPrice('${model.histories![index].price}')} đ',
                                                style: StyleApp.textStyle600(
                                                    fontSize: 15, color: color),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Trạng Thái: ',
                                                style: StyleApp.textStyle400(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                '${model.histories![index].status}',
                                                style: StyleApp.textStyle400(
                                                    fontSize: 15,
                                                    color: colorTT),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              '${Const.convertTime('${model.histories![index].createdAt}')}',
                                              style: StyleApp.textStyle400(
                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      model.histories![index].note != null
                                          ? Text(
                                              'Lý do: ${model.histories![index].note}',
                                              style: StyleApp.textStyle400(
                                                fontSize: 15,
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: model.histories!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
