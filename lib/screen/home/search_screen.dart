import 'package:cs_global/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/product/bloc_search.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_listMostSale.dart';
import '../../model/model_listPro.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../auth/auth_screen.dart';
import 'infoPro_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  BlocSearch blocSearch = BlocSearch();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorApp.redText,
            )),
        actions: [
          InkWell(
              onTap: () {
                search.clear();
              },
              child: Icon(
                Icons.clear,
                color: ColorApp.redText,
              ))
        ],
        backgroundColor: ColorApp.whiteF0,
        title: TextFormField(
          controller: search,
          decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              suffixIcon: InkWell(
                  onTap: () {
                   blocSearch.add(GetData(param: search.text));
                  },
                  child: Icon(Icons.search)),
              hintStyle: StyleApp.textStyle400(fontStyle: FontStyle.italic)),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: blocSearch,
            builder: (_, StateBloc state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.main,
                  ),
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
              if (state is LoadSuccess) {
                List<MostSaleProduct> list=state.data;
                print(list.length);
                return
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InfoProdScreen(
                                        id: list[index]
                                            .id
                                            .toString(),
                                        cateID: list[index]
                                            .category![0]
                                            .id
                                            .toString(),
                                      )));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoProductScreen(id: '${list[index].id}')));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  LoadImage(
                                    url:
                                    '${Const.image_host}${list[index].thumbnail}',
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.2,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${list[index].name}',
                                          style: StyleApp.textStyle700(),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(list[index].discountPrice ?? ''))}đ',
                                              style: StyleApp.textStyle600(
                                                  color: ColorApp.redText, fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${list[index].discount}',
                                              style: StyleApp.textStyle700(
                                                  color: ColorApp.grey4F,
                                                  fontSize: 14,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
              }
              return Container();
            }),
      ),
    );
  }
}
