import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:cs_global/widget/item/input/text_filed2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';

import '../../styles/init_style.dart';
import 'item/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = GroupButtonController();
  List<String> listButton = ['Sản phẩm', 'Dịch vụ', 'Đào Tạo', 'HT Land'];
  int tab = 0;
  List<IconData> listIcon = [
    FontAwesomeIcons.boxArchive,
    FontAwesomeIcons.screwdriverWrench,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.buildingColumns
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.whiteF0,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: InputText1(
                          label: 'Tìm kiếm sản phẩm',
                          colorBg: ColorApp.green,
                          colorLabel: Colors.white,
                          hasLeading: true,
                          iconPreFix: Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.qr_code_scanner_outlined,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        '1',
                                        style: StyleApp.textStyle500(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: GroupButton<String>(
                  buttonIndexedBuilder: (selected, index, context) {
                    return Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width - 10) * 0.235,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selected ? ColorApp.redText : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(listIcon[index],
                              size: 14,
                              color: selected ? Colors.white : ColorApp.green),
                          Text(
                            listButton[index],
                            style: StyleApp.textStyle500(
                                color:
                                    selected ? Colors.white : ColorApp.green),
                          ),
                        ],
                      ),
                    );
                  },
                  controller: controller,
                  options: GroupButtonOptions(
                      selectedTextStyle:
                          StyleApp.textStyle500(color: Colors.white),
                      selectedColor: ColorApp.redText,
                      unselectedTextStyle:
                          StyleApp.textStyle500(color: ColorApp.green),
                      buttonHeight: 50,
                      borderRadius: BorderRadius.circular(12),
                      spacing: (MediaQuery.of(context).size.width - 10) * 0.02,
                      buttonWidth:
                          (MediaQuery.of(context).size.width - 10) * 0.235),
                  isRadio: true,
                  onSelected: (text, index, bool) {
                    tab = index;
                    setState(() {});
                  },
                  buttons: listButton,
                ),
              ),
            ),
          ]),
          tab == 0
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nhóm sản phẩm',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    'Thời trang công sở',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sản phẩm mua nhất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ProductItem();
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sản phẩm E - commerce đề xuất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),

                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.33),
                          itemBuilder: (context, index) {
                            return ProductItem();
                          },
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sản phẩm cùng danh mục',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.33),
                          itemBuilder: (context, index) {
                            return ProductItem();
                          },
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ],
                    ),
                  ),
                ))
              : SizedBox()
        ],
      ),
    );
  }
}
