import 'package:flutter/material.dart';

Color mainColor(BuildContext context){
  return Theme.of(context).colorScheme.background == Colors.grey.shade300?Colors.white:Colors.grey.shade900;
}

// Color secontColor(BuildContext context){
  // return Theme.of(context).colorScheme.background == Colors.grey.shade300?:;
// }