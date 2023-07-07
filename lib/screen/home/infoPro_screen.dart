import 'dart:convert';

import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:cs_global/bloc/cart/model_sp.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/home.dart';
import 'package:cs_global/screen/cart/gio_hang_screen.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_comment.dart';
import '../../bloc/product/bloc_infoPro.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_listPro.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
// import 'package:flutter_quill/flutter_quill.dart' as Quill;
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../../widget/loadPage/item_loadmore.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:html_editor_enhanced/html_editor.dart';


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
  BlocCartLocal blocCartLocal2 = BlocCartLocal();
  double height = 200;
  double rate = 1.0;
  bool isLog = false;
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  // final QuillEditorController Qcontroller = QuillEditorController();
  // Quill.QuillController _Qcontroller = Quill.QuillController.basic();
  final HtmlEditorController Hcontroller = HtmlEditorController();

  ScrollController _controller = ScrollController();
  BlocComment blocComment = BlocComment();
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
    super.initState();
    blocInfoPro.add(GetData(param: widget.id));
    _tabController = TabController(length: 5, vsync: this);
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
              decoration: const BoxDecoration(
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
                                        amount: value,
                                        max: modelInfoPro.product!.amount)));
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
                        const Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 20,
                          child: InkWell(
                            onTap: () {
                              blocCartLocal2.add(AddData(
                                  modelSanPhamMain: ModelSanPhamMain(
                                      id: int.parse('${widget.id}'),
                                      amount: value,
                                      max: modelInfoPro.product!.amount)));
                              context.read<BlocCartLocal>().add(GetCart());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GioHangScreen()));
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
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
        bloc: blocInfoPro,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            BlocBuilder(
                bloc: blocProfile,
                builder: (_, StateBloc state) {
                  if (state is LoadSuccess) {
                    isLog = true;
                  }
                  return SizedBox();
                }),
            BlocBuilder(
                bloc: blocInfoPro,
                builder: (_, StateBloc state) {
                  if (state is Loading) {
                    return const Center(
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
                                        0.5,
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
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
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
                                : const SizedBox(),
                            Positioned(
                              top: 30,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
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
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${modelInfoPro.product!.name}',
                                style: StyleApp.textStyle600(
                                    color: ColorApp.dark, fontSize: 20),
                              ),
                              const SizedBox(
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
                                        child: const Icon(
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
                                        child: const Icon(
                                          Icons.add_circle,
                                          color: ColorApp.redText,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorApp.grey4F,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TabBar(
                                  isScrollable: true,
                                  controller: _tabController,
                                  onTap: (value) {
                                    print(value);
                                    tab = value;
                                    setState(() {});
                                  },
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  labelStyle:
                                      StyleApp.textStyle700(fontSize: 16),
                                  indicatorColor: ColorApp.redText,
                                  unselectedLabelStyle:
                                      StyleApp.textStyle500(fontSize: 14),
                                  labelColor: ColorApp.redText,
                                  unselectedLabelColor: ColorApp.dark500,
                                  tabs: const <Widget>[
                                    Tab(
                                      child: Text(
                                        'Chi tiết',
                                      ),
                                    ),
                                    Tab(
                                      child: Text('Hướng dẫn sử dụng'),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Pháp lý',
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Nhà cung cấp',
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Bình Luận',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              tab == 0
                                  ? Column(
                                      children: [
                                        Container(
                                          height: 15,
                                        ),
                                        Container(
                                          height: height,
                                          child: SingleChildScrollView(
                                            child: HtmlWidget(
                                              '${modelInfoPro.product!.descript}',
                                              textStyle: TextStyle(),
                                              customWidgetBuilder: (ele) {
                                                if (ele.attributes['src'] !=
                                                        null &&
                                                    ele.attributes['src']!
                                                        .startsWith("/media")) {
                                                  return LoadImage(
                                                      url:
                                                          '${Const.image_host}${ele.attributes['src']}');
                                                }
                                              },
                                              onTapUrl: (url) =>
                                                  _launchURL(url),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                height = 500;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: ColorApp.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Xem Thêm ',
                                                        style: StyleApp
                                                            .textStyle500(
                                                                color: ColorApp
                                                                    .green),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color: ColorApp.green,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  : SizedBox(),
                              tab == 1
                                  ? Container(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          '${modelInfoPro.product!.manualUser}',
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
                                  : SizedBox(),
                              tab == 2
                                  ? Container(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          '${modelInfoPro.product!.legalInfo}',
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
                                  : SizedBox(),
                              tab == 3
                                  ? Container(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          '${modelInfoPro.product!.supplierInfo}',
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
                                  : SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              tab == 4
                                  ? Column(
                                      children: [
                                        Text(
                                          'Đánh giá của bạn',
                                          style: StyleApp.textStyle700(),
                                        ),
                                        RatingBar.builder(
                                          initialRating: rate,
                                          itemCount: 5,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: ColorApp.red,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                            rate = rating;
                                          },
                                        ),
                                        HtmlEditor(
                                          htmlToolbarOptions:
                                              HtmlToolbarOptions(

                                            toolbarType:
                                                ToolbarType.nativeScrollable,
                                            defaultToolbarButtons: [

                                              ColorButtons(),
                                              InsertButtons(
                                                  link: false,
                                                  audio: false,
                                                  table: false,
                                                  hr: false),
                                            ],
                                          ),
                                          controller: Hcontroller, //required
                                          htmlEditorOptions: HtmlEditorOptions(
                                            hint: "Nhập bình luận của bạn",
                                            //initalText: "text content initial, if any",
                                          ),
                                          otherOptions: OtherOptions(
                                            height: 400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        BlocListener(
                                          bloc: blocComment,
                                          listener: (_, StateBloc state) {
                                            CheckLogState.check(context,
                                                state: state,
                                                msg: state is LoadSuccess
                                                    ? state.mess
                                                    : 'Thành công',
                                                success: () {
                                              blocInfoPro.add(
                                                  GetData(param: widget.id));
                                            });
                                          },
                                          child: InkWell(
                                            onTap: () async {
                                              String? htmlText =
                                                  await Hcontroller.getText();

                                              if (isLog == false) {
                                                CustomToast.showToast(
                                                    context: context,
                                                    msg:
                                                        'Bạn phải đăng nhập để bình luận');
                                              } else {
                                                blocComment.add(Comment(
                                                    productID:
                                                        int.parse(widget.id),
                                                    star: rate.round(),
                                                    comment: htmlText));
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: ColorApp.blue3D,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 8),
                                                child: Text(
                                                  'Gửi',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // ToolBar.scroll(
                                        //     toolBarColor: Colors.cyan.shade50,
                                        //     activeIconColor: Colors.green,
                                        //     padding: const EdgeInsets.all(8),
                                        //     iconSize: 20,
                                        //     controller: Qcontroller,
                                        //     toolBarConfig: [
                                        //       ToolBarStyle.bold,
                                        //       ToolBarStyle.italic,
                                        //       ToolBarStyle.align,
                                        //       ToolBarStyle.color,
                                        //       ToolBarStyle.size,
                                        //       ToolBarStyle.image
                                        //     ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //     border: Border.all(),
                                        //   ),
                                        //   child: QuillHtmlEditor(
                                        //       hintText:
                                        //           ' Nhập bình luận của bạn',
                                        //       controller: Qcontroller,
                                        //       isEnabled: true,
                                        //       minHeight: 100,
                                        //       hintTextStyle:
                                        //           StyleApp.textStyle500(
                                        //               color: ColorApp.dark500),
                                        //       hintTextAlign: TextAlign.start,
                                        //       padding: const EdgeInsets.only(
                                        //           left: 10, top: 5),
                                        //       hintTextPadding: EdgeInsets.zero,
                                        //       onFocusChanged: (hasFocus) =>
                                        //           debugPrint(
                                        //               'has focus $hasFocus'),
                                        //       onTextChanged: (text) => debugPrint(
                                        //           'widget text change $text'),
                                        //       onEditorCreated: () => debugPrint(
                                        //           'Editor has been loaded'),
                                        //       onEditorResized: (height) =>
                                        //           debugPrint(
                                        //               'Editor resized $height'),
                                        //       onSelectionChanged: (sel) =>
                                        //           debugPrint(
                                        //               '${sel.index},${sel.length}')),
                                        // ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        // BlocListener(
                                        //   bloc: blocComment,
                                        //   listener: (_, StateBloc state) {
                                        //     CheckLogState.check(context,
                                        //         state: state,
                                        //         msg: state is LoadSuccess
                                        //             ? state.mess
                                        //             : 'Thành công',
                                        //     success: (){
                                        //       blocInfoPro.add(GetData(param: widget.id));
                                        //     });
                                        //   },
                                        //   child: InkWell(
                                        //     onTap: () async {
                                        //       Qcontroller.clearHistory();
                                        //       String? htmlText =
                                        //           await Qcontroller.getText();
                                        //       if (isLog == false) {
                                        //         CustomToast.showToast(
                                        //             context: context,
                                        //             msg:
                                        //                 'Bạn phải đăng nhập để bình luận');
                                        //       } else {
                                        //         print(htmlText);
                                        //         // blocComment.add(Comment(
                                        //         //     productID:
                                        //         //         int.parse(widget.id),
                                        //         //     star: rate.round(),
                                        //         //     comment: htmlText));
                                        //       }
                                        //     },
                                        //     child: Container(
                                        //       decoration: BoxDecoration(
                                        //           color: ColorApp.blue3D,
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   20)),
                                        //       child: Padding(
                                        //         padding:
                                        //             const EdgeInsets.symmetric(
                                        //                 horizontal: 30,
                                        //                 vertical: 8),
                                        //         child: Text(
                                        //           'Gửi',
                                        //           style: StyleApp.textStyle500(
                                        //               color: Colors.white),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ListView.builder(
                                          itemBuilder: (context, index) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ClipOval(
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                                    child: LoadImage(
                                                      url:
                                                          '${Const.image_host}${modelInfoPro.product!.comments![index].customerComment!.avatar}',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${modelInfoPro.product!.comments![index].customerComment!.name}',
                                                        style: StyleApp
                                                            .textStyle700(),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      RatingBarIndicator(
                                                        rating: double.parse(
                                                            '${modelInfoPro.product!.comments![index].star}'),
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: ColorApp.red,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 20.0,
                                                        direction:
                                                            Axis.horizontal,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      HtmlWidget(
                                                        '${modelInfoPro.product!.comments![0].descript}',
                                                        customWidgetBuilder:
                                                            (ele) {
                                                          if (ele.attributes[
                                                                  'src'] !=
                                                              null) {
                                                            return Const
                                                                .imageFromBase64String(
                                                                    '${ele.attributes['src']}',
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover);
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          itemCount: modelInfoPro
                                              .product!.comments!.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              Text(
                                'Sản phẩm cùng danh mục',
                                style: StyleApp.textStyle700(
                                    color: ColorApp.darkGreen, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
            BlocBuilder(
                bloc: blocListPro,
                builder: (_, StateBloc state) {
                  if (state is Loading) {
                    return const Scaffold(
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
                        blocListPro
                            .add(GetData(param: widget.cateID.toString()));
                      },
                    );
                  }
                  if (state is LoadSuccess) {
                    List<Prod> model = state.data;
                    final length = state.checkLength;
                    final hasMore = state.hasMore;
                    return Column(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 0,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height *
                                          0.34),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<BlocCartLocal>().add(GetCart());
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
                                    Stack(

                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.34,
                                          width: MediaQuery.of(context).size.width *
                                              0.47,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  SizedBox(
                                                    height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.24,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.47,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(
                                                              12),
                                                          topRight:
                                                          Radius.circular(
                                                              12)),
                                                      child: LoadImage(
                                                        fit: BoxFit.fill,
                                                        url:
                                                        '${Const.image_host}${model![index].thumbnail}',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                            Radius.circular(
                                                                12)),
                                                        image: DecorationImage(
                                                            scale: 0.2,
                                                            image: ExactAssetImage(
                                                                'assets/images/giam.png',
                                                                scale: 0.2),
                                                            fit: BoxFit.fill)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(vertical: 4),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            ' - ${model[index].discount} ',
                                                            style: StyleApp
                                                                .textStyle700(
                                                                color: ColorApp
                                                                    .redText),
                                                          ),
                                                          Text(
                                                            'GIẢM',
                                                            style: StyleApp
                                                                .textStyle700(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 6, vertical: 4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Text(
                                                    //   model
                                                    //           .productSugges![
                                                    //               index]
                                                    //           .code ??
                                                    //       '',
                                                    //   style: StyleApp
                                                    //       .textStyle600(),
                                                    // ),

                                                    Text(
                                                      model[index].name ?? '',
                                                      maxLines: 1,
                                                      textAlign: TextAlign.center,
                                                      style:
                                                      StyleApp.textStyle500(),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),

                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${Const.ConvertPrice.format(int.parse('${model[index].price}'))} đ',
                                                          style: StyleApp.textStyle500(
                                                              decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                        ),
                                                        Text(
                                                          '${Const.ConvertPrice.format(int.parse('${model[index].discountPrice}'))} đ',

                                                          style:
                                                          StyleApp.textStyle700(
                                                              color: ColorApp
                                                                  .redText),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(12),
                                                    topRight: Radius.circular(12)
                                                ),
                                                color: Colors.red),

                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                                              child: Text(
                                                'Còn lại : ${model[index].amount}',
                                                style: StyleApp.textStyle500(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Positioned(

                                      child: BlocListener(
                                        bloc: blocCartLocal,
                                        listener: (context, StateBloc state) {
                                          if (state is LoadSuccess) {
                                            CustomToast.showToast(
                                                context: context,
                                                msg:
                                                'Đã thêm vào giỏ hàng thành công',
                                                duration: 1,
                                                gravity: ToastGravity.BOTTOM);
                                          }
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            blocCartLocal.add(AddData(
                                                modelSanPhamMain:
                                                ModelSanPhamMain(
                                                    id: model[index].id,
                                                    amount: 1,
                                                    max: model[index]
                                                        .amount)));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomRight:
                                                  Radius.circular(12),
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
                                          ),
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
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        ItemLoadMore(
                          hasMore: hasMore,
                          length: length,
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
