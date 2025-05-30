import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? data;
  const InfoWidget({super.key, required this.icon, required this.title, required this.data});
  
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      
      Image.asset(icon, height: 20, width: 20, color: Theme.of(context).disabledColor),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Text('$title:', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).disabledColor)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Flexible(child: Text(data!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge))),
      
    ]);
  }
}
