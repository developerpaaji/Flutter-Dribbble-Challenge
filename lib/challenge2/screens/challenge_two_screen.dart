import 'package:flutter/material.dart';
import 'package:payment/challenge2/modals/page_item.dart';
import 'package:payment/challenge2/screens/headspace_screen.dart';

class ChallengeTwoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_ChallengeTwoScreenState();
  
}
class _ChallengeTwoScreenState extends State<ChallengeTwoScreen>
{
  List<PageItem>items=[
    PageItem(title: "Failure will never overtake me if my determination to succeed is strong enough.",thumbnail: "https://mms.businesswire.com/media/20180320005991/en/646972/5/NBA-Headspace_Illustration_FINAL.jpg"),
    PageItem(title:"Failure will never overtake me if my determination to succeed is strong enough.",thumbnail: "https://nexusstudios.com/app/uploads/2018/04/Headspace_headphones.jpg"),
    PageItem(title:"Failure will never overtake me if my determination to succeed is strong enough.",thumbnail: "https://static.standard.co.uk/s3fs-public/thumbnails/image/2018/11/13/10/headspace-1.jpg?w968"),
    PageItem(title: "Failure will never overtake me if my determination to succeed is strong enough.",thumbnail: "https://uploads-ssl.webflow.com/59d075ab10d34e00017a8217/59db264eaaa78100013f974f_baker_creative_blog13.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 1.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Challenge 3",style: TextStyle(inherit: true,color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("What brings you to the Headspace?",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline,),
              ),
              subtitle:Text("Choose your main reason",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.normal),),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context,index){
                return Hero(
                  tag: items[index].thumbnail,
                  child: GestureDetector(
                    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HeadspaceScreen(items,index)));},
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(borderRadius: BorderRadius.circular(12.0),child: Image.network(items[index].thumbnail,height:75.0,fit: BoxFit.fill,)),
                    ),
                  ),
                );
              },
              itemCount: items.length,
          ),
        ],
      ),
    );
  }
  
}