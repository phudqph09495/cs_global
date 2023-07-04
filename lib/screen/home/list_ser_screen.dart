import 'package:cs_global/bloc/state_bloc.dart';
import 'package:cs_global/widget/item/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/news/bloc_listCateNews.dart';
import '../../bloc/news/bloc_listnews.dart';
import '../../bloc/news/model_cateNews.dart';
import '../../bloc/news/model_listNews.dart';
import '../../bloc/service/bloc_listService.dart';
import '../../bloc/service/bloc_listServiceCate.dart';
import '../../bloc/service/model_listService.dart';
import '../../bloc/service/model_listServiceCate.dart';
import '../../config/const.dart';
import '../../styles/init_style.dart';
import 'package:flutter_html/flutter_html.dart';

import 'detailNews_screen.dart';

class ListSerScreen extends StatefulWidget {
  int initIndex;
  String id;
  ListSerScreen({required this.initIndex, required this.id});

  @override
  State<ListSerScreen> createState() => _ListSerScreenState();
}

class _ListSerScreenState extends State<ListSerScreen>
    with TickerProviderStateMixin {
  BlocListServiceCate blocListSerCate = BlocListServiceCate()..add(GetData());
  BlocListService blocListService=BlocListService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    blocListService.add(GetData(param: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.greyBD,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorApp.green00,
          centerTitle: true,
          title: Text(
            'Dịch vụ',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 22,),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder(
                  bloc: blocListSerCate,
                  builder: (_, StateBloc state) {
                    if (state is LoadSuccess) {
                      ModelListServiceCate model = state.data;
                      TabController? _tabController = TabController(
                          length: model.serviceCate!.length,
                          vsync: this,
                          initialIndex: widget.initIndex);
                      return TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        onTap: (value) {
                          blocListService.add(GetData(param: model.serviceCate![value].id.toString()));

                          // blocListNews.add(GetData(
                          //     param: model.serviceCate![value].id.toString()));
                        },
                        labelPadding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        labelStyle: StyleApp.textStyle700(fontSize: 16),
                        indicatorColor: Colors.transparent,
                        unselectedLabelStyle:
                        StyleApp.textStyle500(fontSize: 14),
                        labelColor: ColorApp.green00,
                        unselectedLabelColor: ColorApp.dark500,
                        tabs: <Widget>[
                          ...List.generate(
                            model.serviceCate!.length,
                                (index) => Tab(
                              child: Text(
                                model.serviceCate![index].name ?? '',
                              ),
                            ),
                          )
                          // Tab(
                          //   child: Text(
                          //     'Chi tiết',
                          //   ),
                          // ),
                        ],
                      );
                    }
                    return SizedBox();
                  }),
              BlocBuilder(
                builder: (_, StateBloc state) {
                  if (state is LoadSuccess) {
                    ModelListService model = state.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: InkWell(
                            onTap: () {
Const.launchURL('${model.services![index].link}');
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: SizedBox(
                                        width:
                                        Const.sizeWidth(context, 65),
                                        height:
                                        Const.sizeWidth(context, 65),
                                        child: LoadImage(
                                          url:
                                          '${Const.image_host}${model.services![index].image}',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: SizedBox(
                                          height:
                                          Const.sizeWidth(context, 65),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${model.services![index].name}'
                                                    .toUpperCase(),
                                                maxLines: 2,
                                                style:
                                                StyleApp.textStyle600(
                                                    color: ColorApp
                                                        .dark500,
                                                    fontSize: 18),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    '',
                                                    style:
                                                    StyleApp.textStyle400(
                                                        color: ColorApp
                                                            .dark500,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    '${Const.convertTime('${model.services![index].createdAt}')}',
                                                    style:
                                                    StyleApp.textStyle400(
                                                        color: ColorApp
                                                            .dark500,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: model.services!.length);
                  }
                  if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorApp.main,
                      ),
                    );
                  }
                  return SizedBox();
                },
                bloc: blocListService,
              )
            ],
          ),
        ));
  }
}
