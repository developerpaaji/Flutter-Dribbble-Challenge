import 'package:flutter/material.dart';
import 'package:payment/models/credit_card.dart';
import 'package:payment/resources/database.dart' as db;
import 'package:payment/screens/credit_card_screen.dart';
import 'package:payment/widgets/credit_card_widget.dart';
import 'package:payment/widgets/history_widget.dart';
import 'package:payment/widgets/send_money_widget.dart';

class PaymentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_PaymentScreenState();
  
}
class _PaymentScreenState extends State<PaymentScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffafafa),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Home",style: TextStyle(inherit: true,color: Colors.black),),
          centerTitle: true,
          actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
          ],
        ),
        body: ListView(
          children: <Widget>[
            _buildCreditCards(),
            SendMoneyWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: HistoryWidget(),
            )
          ],
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Dribble Challenge",style: TextStyle(inherit: true,fontWeight: FontWeight.w600,fontSize: 18.0),),
              ),
              ListTile(
                leading: IconButton(icon: Icon(Icons.payment), onPressed: null),
                title: Text("Payments"),
              ),
              ListTile(
                leading: IconButton(icon: Icon(Icons.graphic_eq), onPressed: null),
                title: Text("Statistics"),
              ),
              ListTile(
                leading: IconButton(icon: Icon(Icons.person), onPressed: null),
                title: Text("Profile"),
              )
            ],
          ),
        ),
       );
  }

  Widget _buildCreditCards(){
    var creditCards=db.getCreditCards();
    return Container(
      height: 250.0,
      margin: EdgeInsets.only(left: 4.0),
      child: ListView.builder(
          itemBuilder:(context,index){
            CreditCard creditCard=creditCards[index];
            Color color=index%2==0?Colors.white:Theme.of(context).primaryColor;

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreditCardScreen(creditCard,themeColor:color ,)));},child: CreditCardWidget(creditCard,collapsed:true,themeColor: color,)),
            );
          },
          itemCount: creditCards.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
      ),
    );
  }
}