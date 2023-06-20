import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:cs_global/bloc/cart/model_sp.dart';
import 'package:cs_global/screen/cart/gio_hang_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_infoPro.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_listPro.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../../widget/loadPage/item_loadmore.dart';

class InfoProdScreen extends StatefulWidget {
  String id;
  String cateID;
  InfoProdScreen({required this.id, required this.cateID});

  @override
  State<InfoProdScreen> createState() => _InfoProdScreenState();
}

class _InfoProdScreenState extends State<InfoProdScreen>
    with TickerProviderStateMixin {
  BlocInfoPro blocInfoPro = BlocInfoPro();
  int pageIMG = 0;
  int value = 1;
  int tab = 0;
  int sum = 0;
  TabController? _tabController;
  BlocListPro blocListPro = BlocListPro();
  int page = 1;
  BlocCartLocal blocCartLocal = BlocCartLocal();
  BlocProfile blocProfile = BlocProfile()..add(GetData());

  ScrollController _controller = ScrollController();
  Future<void> onRefresh() async {
    page = 1;
    blocListPro.add(LoadMoreEvent(
        page: page, cleanList: true, id: widget.cateID.toString()));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocListPro.add(LoadMoreEvent(
            page: page, loadMore: true, id: widget.cateID.toString()));
      }
    });
  }

  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocInfoPro.add(GetData(param: widget.id));
    _tabController = TabController(length: 2, vsync: this);
    onRefresh();
    loadmore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder(
        builder: (_, StateBloc state) {
          if (state is LoadSuccess) {
            ModelInfoPro modelInfoPro = state.data;
            sum = int.parse('${modelInfoPro.product!.discountPrice}') * value;
            return Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: ColorApp.dark500, width: 1.5))),
              height: 85,
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
                          child: BlocListener(
                            bloc: blocCartLocal,
                            listener: (_, StateBloc state) {
                              if (state is LoadSuccess) {
                                context.read<BlocCartLocal>().add(GetCart());
                                CustomToast.showToast(
                                    context: context,
                                    msg: 'Đã thêm vào giỏ hàng thành công',
                                    duration: 1,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                blocCartLocal.add(AddData(
                                    modelSanPhamMain: ModelSanPhamMain(
                                        id: int.parse('${widget.id}'),
                                        amount: value,max: modelInfoPro.product!.amount)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorApp.redText),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Thêm vào giỏ',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.dark500),
                                    textAlign: TextAlign.center,
                                  ),
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
                          child: BlocListener(
                            bloc: blocCartLocal,
                            listener: (_, StateBloc state) {
                              context.read<BlocCartLocal>().add(GetCart());
                            },
                            child: InkWell(
                              onTap: () {
                                blocCartLocal.add(AddData(
                                    modelSanPhamMain: ModelSanPhamMain(
                                        id: int.parse('${widget.id}'),
                                        amount: value,max: modelInfoPro.product!.amount)));
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GioHangScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorApp.redText),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Mua ngay',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.whiteF0),
                                    textAlign: TextAlign.center,
                                  ),
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
            );
          }
          return SizedBox();
        },
        bloc: blocInfoPro,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            BlocBuilder(
              builder: (_, StateBloc statePro) {
                if (statePro is LoadFail) {
                  Future.delayed(Duration(seconds: 1), () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              statePro.error,
                              style: StyleApp.textStyle500(),
                            ),
                            actions: [
                              InkWell(
                                onTap: () async {
                                  await SharePrefsKeys.removeAllKey();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StartScreen()));
                                },
                                child: Container(
                                    width: double.infinity,
                                    decoration:
                                    BoxDecoration(color: Colors.green),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Quay lại trang đăng nhập',
                                        textAlign: TextAlign.center,
                                        style: StyleApp.textStyle500(
                                            color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                          );
                        });
                    // await SharePrefsKeys.removeAllKey();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => StartScreen()));
                  });
                  return SizedBox();
                }
                return SizedBox();
              },
              bloc: blocProfile,
            ),
            BlocBuilder(
                bloc: blocInfoPro,
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
                        blocInfoPro.add(GetData(param: widget.id));
                      },
                    );
                  }
                  if (state is LoadSuccess) {
                    ModelInfoPro modelInfoPro = state.data;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            modelInfoPro.product!.imagesShow!.length > 0
                                ? ImageSlideshow(
                                    onPageChanged: (val) {
                                      setState(() {
                                        pageIMG = val + 1;
                                      });
                                    },
                                    initialPage: pageIMG,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    width: double.infinity,
                                    indicatorBackgroundColor:
                                        Colors.transparent,
                                    indicatorColor: Colors.transparent,
                                    isLoop: true,
                                    autoPlayInterval: 2000,
                                    children: List.generate(
                                        modelInfoPro
                                            .product!.imagesShow!.length,
                                        (index) => LoadImage(
                                              fit: BoxFit.cover,
                                              url:
                                                  '${Const.image_host}${modelInfoPro.product!.imagesShow![index].url}',
                                            )),
                                  )
                                : LoadImage(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    fit: BoxFit.cover,
                                    url: '',
                                  ),
                            Positioned(
                              top: 30,
                              left: 10,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            modelInfoPro.product!.imagesShow!.length > 0
                                ? Positioned(
                                    top: 30,
                                    left: Const.size(context).width * 0.45,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        child: Text(
                                          '${pageIMG}/${modelInfoPro.product!.imagesShow!.length}',
                                          style: StyleApp.textStyle500(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Positioned(
                              top: 30,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Icon(
                                    Icons.share_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${modelInfoPro.product!.name}',
                                style: StyleApp.textStyle600(
                                    color: ColorApp.dark, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Const.ConvertPrice.format(int.parse('${modelInfoPro.product!.discountPrice}'))} đ',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.redText, fontSize: 17),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (value > 0) {
                                            setState(() {
                                              value--;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: ColorApp.redText,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        '    ${value.toString()}    ',
                                        style: StyleApp.textStyle500(),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            value++;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: ColorApp.redText,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TabBar(
                                isScrollable: true,
                                controller: _tabController,
                                onTap: (value) {
                                  print(value);
                                  tab = value;
                                  setState(() {});
                                },
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 30),
                                labelStyle: StyleApp.textStyle700(fontSize: 16),
                                indicatorColor: ColorApp.redText,
                                unselectedLabelStyle:
                                    StyleApp.textStyle500(fontSize: 14),
                                labelColor: ColorApp.redText,
                                unselectedLabelColor: ColorApp.dark500,
                                tabs: <Widget>[
                                  Tab(
                                    child: Text(
                                      'Chi tiết',
                                    ),
                                  ),
                                  Tab(
                                    child: Text('Hướng dẫn sử dụng'),
                                  ),
                                ],
                              ),
                              tab == 0
                                  ? Container(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          '${modelInfoPro.product!.descript}',
                                          customWidgetBuilder: (ele) {
                                            if (ele.attributes['src'] != null &&
                                                ele.attributes['src']!
                                                    .startsWith("/media")) {
                                              return LoadImage(
                                                  url:
                                                      '${Const.image_host}${ele.attributes['src']}');
                                            }
                                          },
                                          onTapUrl: (url) => _launchURL(url),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          '${modelInfoPro.product!.descript}',
                                          customWidgetBuilder: (ele) {
                                            if (ele.attributes['src'] != null &&
                                                ele.attributes['src']!
                                                    .startsWith("/media")) {
                                              return LoadImage(
                                                  url:
                                                      '${Const.image_host}${ele.attributes['src']}');
                                            }
                                          },
                                          onTapUrl: (url) => _launchURL(url),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Scaffold();
                }),
            BlocBuilder(
                bloc: blocListPro,
                builder: (_, StateBloc state) {
                  if (state is Loading) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(
                          color: ColorApp.main,
                        ),
                      ),
                    );
                  }
                  if (state is LoadFail) {
                    return ItemLoadFaild(
                      error: state.error,
                      onTap: () {
                        blocListPro.add(GetData(param: widget.id.toString()));
                      },
                    );
                  }
                  if (state is LoadSuccess) {
                    List<Prod> model = state.data;
                    final length = state.checkLength;
                    final hasMore = state.hasMore;
                    return Column(
                      children: [
                        Text(
                          'Sản phẩm cùng danh mục',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 0,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height *
                                          0.33),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoProdScreen(
                                              id: model[index].id.toString(),
                                              cateID: widget.cateID.toString(),
                                            )));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      width: MediaQuery.of(context).size.width *
                                          0.48,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.19,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.48,
                                              child: LoadImage(
                                                fit: BoxFit.cover,
                                                url:
                                                    '${Const.image_host}${model[index].thumbnail}',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.12,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    model[index].code ?? '',
                                                    style:
                                                        StyleApp.textStyle600(),
                                                  ),
                                                  Text(
                                                    model[index].name ?? '',
                                                    style:
                                                        StyleApp.textStyle500(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Giá bán: ',
                                                        style: StyleApp
                                                            .textStyle500(),
                                                      ),
                                                      Text(
                                                        '${Const.ConvertPrice.format(int.parse('${model[index].price}'))}',
                                                        style: StyleApp
                                                            .textStyle700(
                                                                color: ColorApp
                                                                    .redText),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                          color: Colors.red),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: model.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        ItemLoadMore(
                          hasMore: hasMore,
                          length: length,
                        ),
                      ],
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
