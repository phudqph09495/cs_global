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
import '../../config/const.dart';
import '../../styles/init_style.dart';
import 'package:flutter_html/flutter_html.dart';

import 'detailNews_screen.dart';

class ListNewsScreen extends StatefulWidget {
  int initIndex;
  String id;
  ListNewsScreen({required this.initIndex, required this.id});

  @override
  State<ListNewsScreen> createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen>
    with TickerProviderStateMixin {
  BlocListNewsCate blocListNewsCate = BlocListNewsCate()..add(GetData());
  BlocListNews blocListNews = BlocListNews();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    blocListNews.add(GetData(param: widget.id));
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
            'Tin tức',
            style: StyleApp.textStyle400(color: Colors.black, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder(
                  bloc: blocListNewsCate,
                  builder: (_, StateBloc state) {
                    if (state is LoadSuccess) {
                      ModelListNewCate model = state.data;
                      TabController? _tabController = TabController(
                          length: model.newsCate!.length,
                          vsync: this,
                          initialIndex: widget.initIndex);
                      return TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        onTap: (value) {
                          blocListNews.add(GetData(
                              param: model.newsCate![value].id.toString()));
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
                            model.newsCate!.length,
                            (index) => Tab(
                              child: Text(
                                model.newsCate![index].name ?? '',
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
                    ModelListNews model = state.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailNewsScreen(
                                                title:
                                                    "${model.allNews![index].title}",
                                                dess:
                                                    '${model.allNews![index].descript}',
                                              )));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: SizedBox(
                                            width:
                                                Const.sizeWidth(context, 115),
                                            height:
                                                Const.sizeWidth(context, 115),
                                            child: LoadImage(
                                              url:
                                                  '${Const.image_host}${model.allNews![index].banner}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${model.allNews![index].title}'
                                                          .toUpperCase(),
                                                      maxLines: 2,
                                                      style:
                                                          StyleApp.textStyle600(
                                                              color: ColorApp
                                                                  .dark500,
                                                              fontSize: 18),
                                                    ),
                                                    Html(
                                                      data:
                                                          '${model.allNews![index].descript}',
                                                      style: {
                                                        '#': Style(
                                                          maxLines: 2,
                                                          textOverflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      },
                                                    ),
                                                    // HtmlWidget(
                                                    //   '${model.allNews![index].descript}',
                                                    //   customWidgetBuilder: (ele) {
                                                    //     if (ele.attributes['src'] != null &&
                                                    //         ele.attributes['src']!
                                                    //             .startsWith("/media")) {
                                                    //       return LoadImage(
                                                    //           url:
                                                    //           '${Const.image_host}${ele.attributes['src']}');
                                                    //     }
                                                    //   },
                                                    //   onTapUrl: (url) =>Const.launchURL(url),
                                                    // )
                                                    // Text(
                                                    //   'Phòng chuẩn đẳng cấp cho các Master với các không gian sang trọng ,hiện đại',
                                                    //   maxLines: 2,
                                                    //   style: StyleApp.textStyle500(
                                                    //       color: ColorApp.dark500,
                                                    //       decoration: TextDecoration.none),
                                                    // ),
                                                  ],
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
                                                      '${Const.convertTime('${model.allNews![index].createdAt}')}',
                                                      style:
                                                          StyleApp.textStyle400(
                                                              color: ColorApp
                                                                  .dark500,
                                                              fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        itemCount: model.allNews!.length);
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
                bloc: blocListNews,
              )
            ],
          ),
        ));
  }
}
