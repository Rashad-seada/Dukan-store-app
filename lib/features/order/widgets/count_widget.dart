import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/images.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:flutter/material.dart';

class CountWidget extends StatelessWidget {
  final String title;
  final int? count;
  const CountWidget({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Column(children: [

          Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor)),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(Images.order, color: Theme.of(context).cardColor, height: 12, width: 12),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),

            Text(count.toString(), style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor,
            )),

          ]),

        ]),
      ),
    );
  }
}
