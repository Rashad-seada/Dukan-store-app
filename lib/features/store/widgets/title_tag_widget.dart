import 'package:flutter/material.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';

class TitleTagWidget extends StatelessWidget {
  final String title;
  const TitleTagWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35, width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),

      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.1))),
      ),
      child: Text(title, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
    );
  }
}
