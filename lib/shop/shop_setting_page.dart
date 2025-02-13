

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/shop/pay_type_dialog.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/my_button.dart';

import 'freight_config_page.dart';
import 'input_text_page.dart';
import 'price_input_dialog.dart';
import 'send_type_dialog.dart';

class ShopSettingPage extends StatefulWidget {
  @override
  _ShopSettingPageState createState() => _ShopSettingPageState();
}

class _ShopSettingPageState extends State<ShopSettingPage> {

  bool check = false;
  var selectValue = [0];
  int sendType = 0;
  String sendPrice = "0.00";
  String freePrice = "0.00";
  String phone = "";
  String shopIntroduction = "零食铺子坚果饮料美酒佳肴…";
  String securityService = "假一赔十";
  
  _getPayType(){
    String payType = "";
    for (int s in selectValue){
      if (s == 0){
        payType = "$payType在线支付+";
      }else if(s == 1){
        payType = "$payType对公转账+";
      }else if(s == 2){
        payType = "$payType货到付款+";
      }
    }
    return payType.substring(0, payType.length - 1);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 防止键盘弹出，提交按钮升起。。。
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            check ? "正在营业" : "暂停营业",
                            style: TextStyles.textBoldDark24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Switch.adaptive(
                            value: check,
                            onChanged: (bool val) {
                              setState(() {
                                check = !check;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("基础设置", style: TextStyles.textBoldDark18),
                    ),
                    Gaps.vGap16,
                    ClickItem(
                      title: "店铺简介",
                      content: shopIntroduction,
                      onTap: (){
                        AppNavigator.pushResult(context,
                            InputTextPage(
                              title: "店铺简介",
                              hintText: "这里有一段完美的简介…",
                              content: shopIntroduction,
                            ), (result){
                              setState(() {
                                shopIntroduction =result.toString();
                              });
                            });
                      },
                    ),
                    ClickItem(
                      title: "保障服务",
                      content: securityService,
                      onTap: (){
                        AppNavigator.pushResult(context,
                          InputTextPage(
                            title: "保障服务",
                            hintText: "这里有一段完美的说明…",
                            content: securityService,
                          ), (result){
                            setState(() {
                              securityService =result.toString();
                            });
                          });
                      },
                    ),
                    ClickItem(
                      title: "支付方式",
                      content: _getPayType(),
                      onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return PayTypeDialog(
                                value: selectValue,
                                onPressed: (value){
                                  setState(() {
                                    selectValue = value;
                                  });
                                },
                              );
                            });
                      },
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("运费设置", style: TextStyles.textBoldDark18),
                    ),
                    ClickItem(
                      title: "运费配置",
                      content: sendType == 0 ? "运费满免配置" : "运费比例配置",
                      onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return SendTypeDialog(
                                onPressed: (i, value){
                                  setState(() {
                                    sendType = i;
                                  });
                                },
                              );
                            });
                      },
                    ),
                    Offstage(
                      offstage: sendType == 1,
                      child: ClickItem(
                        title: "运费满免",
                        content: freePrice,
                        onTap: (){
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PriceInputDialog(
                                  title: "配送费满免",
                                  onPressed: (value){
                                    setState(() {
                                      freePrice = value;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    Offstage(
                      offstage: sendType == 1,
                      child: ClickItem(
                        title: "配送费用",
                        content: sendPrice,
                        onTap: (){
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PriceInputDialog(
                                  title: "配送费用",
                                  onPressed: (value){
                                    setState(() {
                                      sendPrice = value;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    Offstage(
                      offstage: sendType == 0,
                      child: ClickItem(
                        maxLines: 10,
                        title: "运费比例",
                        content: "1、订单金额<20元，配送费为订单金额的1%\n2、订单金额≥20元，配送费为订单金额的1%",
                        onTap: (){
                          AppNavigator.push(context, FreightConfigPage());
                        },
                      ),
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("联系信息", style: TextStyles.textBoldDark18,),
                    ),
                    Gaps.vGap16,
                    ClickItem(
                      title: "联系电话",
                      content: phone,
                      onTap: (){
                        AppNavigator.pushResult(context, 
                            InputTextPage(
                              title: "联系电话",
                              hintText: "这里有一串神秘的数字…",
                              keyboardType: TextInputType.phone,
                              content: phone,
                            ), (result){
                              setState(() {
                                phone =result.toString();
                              });
                        });
                      },
                    ),
                    ClickItem(
                      maxLines: 2,
                      title: "店铺地址",
                      content: "陕西省 西安市 长安区 郭杜镇郭北村韩林路圣方医院斜对面",
                      onTap: (){},
                    ),
                    Gaps.vGap8,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                text: "提交",
              ),
            )
          ],
        ),
      ),
    );
  }

}
