
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

class PayTypeDialog extends StatefulWidget{

  PayTypeDialog({
    Key key,
    this.value,
    this.onPressed,
  }) : super(key : key);

  final List<int> value;
  final Function(List) onPressed;
  
  @override
  _PayTypeDialog createState() => _PayTypeDialog();
  
}

class _PayTypeDialog extends State<PayTypeDialog>{

  List selectValue;
  var list = ["线上支付", "对公转账", "货到付款"];

  Widget getItem(int index){
    selectValue = widget.value ?? [0];
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  list[index],
                  style: TextStyles.textDark14,
                ),
              ),
              Image.asset(Utils.getImgPath(selectValue.contains(index) ? "shop/xz" : "shop/xztm"), width: 16.0, height: 16.0),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
          if (mounted) {
            if (index == 0){
              Toast.show("线上支付为必选项");
              return;
            }
            setState(() {
              if (selectValue.contains(index)){
                selectValue.remove(index);
              }else{
                selectValue.add(index);
              }
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "支付方式(多选)",
      height: 242.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getItem(0),
          getItem(1),
          getItem(2),
        ],
      ),
      onPressed: (){
        widget.onPressed(selectValue);
        Navigator.of(context).pop();
      },
    );
  }
}