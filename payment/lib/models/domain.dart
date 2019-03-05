import 'package:flutter/material.dart';

class Domain{
  final String value;
  final Color color;

  Domain(this.value, this.color);

  static List<Domain> getDomain(List<String>values,List<Color>colors)
  {
    assert(values.length==colors.length);
    List<Domain> domains=[];
    for(int i=0;i<colors.length;i++)
      {
        domains.add(Domain(values[i],colors[i]));
      }
    return domains;
  }
}