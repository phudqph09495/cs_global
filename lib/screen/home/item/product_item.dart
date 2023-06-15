import 'package:flutter/material.dart';

import '../../../styles/init_style.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height:
            MediaQuery.of(context).size.height *
                0.33 ,
            width: MediaQuery.of(context).size.width *
                0.45,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius:
                BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context)
                      .size
                      .height *
                      0.2,
                  width: MediaQuery.of(context)
                      .size
                      .width *
                      0.45,
                  color: Colors.green,
                ),
                Container(
                  height:
                  MediaQuery.of(context).size.height *
                      0.12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '[Nhập khẩu Hàn]',
                          style:
                          StyleApp.textStyle600(),
                        ),

                        Text(
                          'Miếng tẩy da chết đang sdnfsdfh sdifhsdhnfsd ',
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
                              '300.000đ',
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
    );
  }
}
