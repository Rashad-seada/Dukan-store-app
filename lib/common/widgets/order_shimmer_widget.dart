import 'package:dukan_store_app/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OrderShimmerWidget extends StatelessWidget {
  final bool isEnabled;
  const OrderShimmerWidget({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      enabled: isEnabled,
      child: Column(children: [

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 15, width: 100, color: Colors.grey[300]),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Container(height: 10, width: 150, color: Colors.grey[300]),
            ]),

            Icon(Icons.keyboard_arrow_right, size: 30, color: Theme.of(context).disabledColor),

          ]),
        ),

        Divider(color: Theme.of(context).disabledColor),

      ]),
    );
  }
}
