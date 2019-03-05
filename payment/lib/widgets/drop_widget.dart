import 'package:flutter/material.dart';

class DropWidget extends StatefulWidget{
  final Map<String,List<String>> options;
  final Function onChange;
  final String mainValue;
  const DropWidget(this.options, this.onChange,{Key key, this.mainValue, }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_DropWidgetState();

}
class _DropWidgetState extends State<DropWidget>{
  String mainValue;
  String subValue;
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    mainValue=widget.mainValue==null?widget.options.keys.first:widget.mainValue;
    subValue=widget.options[mainValue][0];
    controller=ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: createDropWidget(),
          ),
          Expanded(
            flex: 1,
            child:createList()
          ),
        ],
      ),
    );
  }
  Widget createDropWidget()
  {
    return OutlineButton(
      child: DropdownButton<String>(
        value: mainValue,
        onChanged: (String newValue) {
          setState(() {
            mainValue = newValue;
            controller.animateTo(0.0, duration: Duration(milliseconds: 25), curve: ElasticInOutCurve());
            widget.onChange(mainValue,0);
          });
        },
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16.0,),
        elevation: 2,
        items: widget.options.keys
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(inherit: true,fontWeight: FontWeight.w600),),
          );
        })
            .toList(),),
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
  }
  Widget createList()
  {
    if(!widget.options[mainValue].contains(subValue))
    {
      subValue=widget.options[mainValue][0];
    }
    List<Widget> texts=widget.options[mainValue].map((value){

      if(value==subValue)
        {
          return Text(value,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.0,color: Colors.black),);
        }
      return Text(value,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.0,color: Colors.pink.shade100),);

    }).toList();
    return ListView.builder(
      itemBuilder: (content,index){
        Text text=texts[index];
        return InkWell(
                  child:Container(alignment: Alignment.center,padding: EdgeInsets.symmetric(horizontal: 12.0),child: text,),
                  onTap: (){
                    this.setState((){subValue=text.data;widget.onChange(mainValue,index);});
                    },);
      },
      itemCount: widget.options[mainValue].length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: controller,
    );
  }
}