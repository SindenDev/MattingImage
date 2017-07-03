import QtQuick 2.0

ListModel {
      //平地
      ListElement {type:"lumian" ;name: "路面" }
      ListElement {type:"rexingdao" ; name: "人行道"}
      ListElement {type:"tingchechang" ; name: "停车场"}
      ListElement {type:"tieguilu" ; name: "铁轨路"}
      //
      ListElement {type:"xingren" ; name: "行人"}
      ListElement {type:"qicheren" ; name: "骑车人"}
      ListElement {type:"zuocheren" ; name: "坐的人"}
      //
      ListElement {type:"xiaoqiche" ; name: "小汽车"}
      ListElement {type:"kache" ; name: "卡车"}
      ListElement {type:"bashi" ; name: "巴士"}
      ListElement {type:"youguiche" ; name: "有轨车"}
      ListElement {type:"motuoche" ; name: "摩托车"}
      ListElement {type:"zixingche" ; name: "自行车"}
      ListElement {type:"fangche" ; name: "房车"}
      ListElement {type:"tuoche" ; name: "拖车"}
      ListElement {type:"xingliyinger" ; name: "行李车\n婴儿车"}
      //
      ListElement {type:"lou" ; name: "楼"}
      ListElement {type:"qiang" ; name: "墙"}
      ListElement {type:"chalan" ; name: "栅栏"}
      ListElement {type:"hulan" ; name: "护栏"}
      ListElement {type:"qiao" ; name: "桥"}
      ListElement {type:"suidao" ; name: "隧道"}
      ListElement {type:"gongmen" ; name: "拱门"}
      //
      ListElement {type:"gan" ; name: "杆"}
      ListElement {type:"ganqun" ; name: "杆群"}
      ListElement {type:"jiaotongdeng" ; name: "交通标"}

      //
      ListElement {type:"zhibei" ; name: "植被"}
      ListElement {type:"dixing" ; name: "地形"}
      //
      ListElement {type:"tiankong" ; name: "天空"}
      ListElement {type:"dongtaiti" ; name: "动态体"}
      ListElement {type:"jingtaiti" ; name: "静态体"}
      //
      ListElement {type:"zhixing" ; name: "直行"}
      ListElement {type:"youzhuan" ; name: "右转"}
      ListElement {type:"zuozhuan" ; name: "左转"}
      ListElement {type:"diaotou" ; name: "调头"}
      ListElement {type:"zhixingyouzhuan" ; name: "直行\n右转"}
      ListElement {type:"zhixingzuozhuan" ; name: "直行\n左转"}
      ListElement {type:"zhixingdiaotou" ; name: "直行\调头"}
      ListElement {type:"other" ; name: "其他"}
      //
      ListElement {type:"shichedao" ; name: "实车道"}
      ListElement {type:"xuchedao" ; name: "虚车道"}
      ListElement {type:"renxingdao" ; name: "人行道"}
      ListElement {type:"tingchedao" ; name: "停车线"}
      ListElement {type:"other" ; name: "其它"}
}
