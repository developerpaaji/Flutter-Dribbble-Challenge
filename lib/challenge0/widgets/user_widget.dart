import 'package:flutter/material.dart';
import 'package:payment/challenge0/models/user.dart';

class UserWidget extends StatelessWidget
{
  final User user;
  const UserWidget({Key key, this.user}) : assert(user!=null),super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 105.0,
      width: 105.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: Colors.pink.shade100,blurRadius: 20.0,spreadRadius: 0.5,offset: Offset(0.0, 0.0)),BoxShadow(color: Colors.white,blurRadius: 20.0,spreadRadius: 10.5)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(user.profilePic),backgroundColor: Color(0xfff1f3f5),),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text(user.name,style: TextStyle(inherit: true,fontWeight: FontWeight.w500,fontSize: 14.0),overflow: TextOverflow.fade,textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
  
}