import 'package:flutter/material.dart';
import 'package:payment/challenge2/modals/page_item.dart';
import 'package:payment/challenge2/widgets/status_widget.dart';


class HeadspaceScreen extends StatefulWidget{
  final List<PageItem>items;
  final int current;
  const HeadspaceScreen( this.items,this.current,{Key key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() =>_HeadspaceScreenState();
  
}
class _HeadspaceScreenState extends State<HeadspaceScreen>
{
  int current=0;
  PageController pageController;
  @override
  void initState() {
    pageController=PageController(initialPage: widget.current);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height*2/4;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
              child: StatusWidget(pageController:pageController,totalCount: widget.items.length, primary: Colors.pink, secondary: Color(0xffeeeeee), duration: Duration(seconds: 2),),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("What brings you to the Headspace?",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline,),
              ),
              subtitle:Text("Choose your main reason",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.normal),),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: PageView.builder(
                    controller: pageController,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return buildWidget(index);
                    },
                    itemCount: widget.items.length,
                  onPageChanged: (index){
                   setState(() {
                     current=index;
                   });
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:RaisedButton(onPressed: () {},padding: EdgeInsets.all(16.0),child: Text("NEXT",style: TextStyle(color: Colors.white,fontSize: 16.0),),color: Colors.pink,),
      ),
    );
  }
  Widget buildWidget(int index)
  {

    return Hero(
      tag: widget.items[index].thumbnail,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: AnimatedContainer(
              width: 160.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              duration: Duration(seconds: 2),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12.0),border: current==index? Border.all(color: Colors.pink,width: 4.0):Border()),
              child:Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(borderRadius: BorderRadius.circular(12.0),child: Image.network(widget.items[index].thumbnail,width: 150.0,height:210.0,fit: BoxFit.fill,)),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AnimatedOpacity(child:Text(widget.items[index].title,style: Theme.of(context).textTheme.title.copyWith(fontSize: 16.0),textAlign: TextAlign.center,), duration:Duration(seconds: 2), opacity: 1.0),
          )
        ],
      ),
    );
  }
}
