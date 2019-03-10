import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment/challenge0/models/balance.dart';
import 'package:payment/challenge0/models/credit_card.dart';
import 'package:payment/challenge0/models/domain.dart';
import 'package:payment/challenge0/widgets/credit_card_widget.dart';
import 'package:payment/challenge0/widgets/drop_widget.dart';
import 'package:payment/challenge0/widgets/group_bar_chart.dart';
import 'package:payment/challenge0/resources/database.dart' as db;
import 'package:payment/challenge0/widgets/history_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:payment/challenge0/widgets/payment_widget.dart';

class CreditCardScreen extends StatefulWidget{
  final CreditCard creditCard;
  final Color themeColor;
  const CreditCardScreen( this.creditCard,{Key key, this.themeColor=Colors.white,}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>_CreditCardScreenState();
  
}
class _CreditCardScreenState extends State<CreditCardScreen>
{
  final Map<String,List<String>>timeValues={
    "Day":["Mon","Tue","Wed","Thur","Fri","Sat","Sun"],
    "Month":["Jan","Feb","Mar","Apr","May","June","July","Sep","Oct","Nov","Dec"],
    "Year":List.generate(21, (index)=>"20${index+1}").skip(10).toList()
  };
  String mainValue="Year";
  int subIndex=0;
  List<charts.Series<Balance, String>>series;
  @override
  void initState() {
    series=db.getSeries(mainValue, subIndex,max:10);
    super.initState();
    updateData();
  }
  updateData()async{
    Timer(Duration(milliseconds: 400),(){
      setState(() {
        series=db.getSeries(mainValue, subIndex,max:1000);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();}),
        title: Text("Payments",style: TextStyle(inherit: true,color: Colors.black),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal:20.0),
            child: CreditCardWidget(widget.creditCard,collapsed: false,themeColor: widget.themeColor,),
          ),
          DropWidget(timeValues,(mainValue,subIndex){
            setState(() {
              if(this.mainValue!=mainValue)
                this.mainValue=mainValue;
              if(this.subIndex!=subIndex)
                this.subIndex=subIndex;
              series=db.getSeries(mainValue, subIndex,max:1000);
            });
          },mainValue: mainValue,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GroupedBarChart(Domain.getDomain(["Income","Expenditure"], [Color(0xff1274ED),Color(0xffeeeeee)]),series),
          ),
          HistoryWidget()
        ],
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  
}