import 'package:flutter/material.dart';
import 'package:payment/challenge0/screens/payment_screen.dart';
import 'package:payment/challenge1/screens/challenge_one_screen.dart';
import 'package:payment/challenge2/screens/challenge_two_screen.dart';
import 'package:payment/challenge2/screens/headspace_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
      routes: {
        "/challenge1":(context)=>ChallengeOneScreen(),
        "/challenge0":(context)=>PaymentScreen(),
        "/challenge2":(context)=>ChallengeTwoScreen()
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Flutter Dribbble Challenge"),
      ),
      body: ListView.builder(
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(child: Text("Challenge$index"), onPressed: () {Navigator.of(context).pushNamed("/challenge$index");},),
            );
          },
        itemCount: 3,
        shrinkWrap: true,
      ),
    );
  }



}
