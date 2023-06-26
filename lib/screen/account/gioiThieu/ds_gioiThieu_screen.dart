import 'package:cs_global/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/gioiThieu/bloc_dsGTtoken.dart';
import '../../../bloc/gioiThieu/model_dsGTtoken.dart';
import '../../../bloc/state_bloc.dart';
import '../../../styles/init_style.dart';
import '../../../widget/loadPage/item_loadfaild.dart';
import 'ct_gioiThieu_screen.dart';

class DSGTLogin extends StatefulWidget {
  @override
  State<DSGTLogin> createState() => _DSGTLoginState();
}

class _DSGTLoginState extends State<DSGTLogin> {
  BlocGTLogin blocGTLogin = BlocGTLogin()..add(GetData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            'Danh sách khách hàng được giới thiệu',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: blocGTLogin,
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
              ModelDSGtLogin modelDSGtLogin = state.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Danh sách đăng ký đại lý',
                        style: StyleApp.textStyle700(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          Color? color;
                          String name = '';
                          switch (modelDSGtLogin.referCustomer![index].type) {
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
                                                  "${modelDSGtLogin.referCustomer![index].name}",
                                              id: '${modelDSGtLogin.referCustomer![index].id}',
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
                                    '${index}.${modelDSGtLogin.referCustomer![index].name} (${name})',
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
                        itemCount: modelDSGtLogin.referCustomer!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }
}
