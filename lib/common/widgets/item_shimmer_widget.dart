import 'package:dukan_store_app/common/widgets/rating_bar_widget.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:flutter/material.dart';

class ItemShimmerWidget extends StatelessWidget {
  final bool isEnabled;
  final bool hasDivider;
  const ItemShimmerWidget({super.key, required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            child: Row(children: [

              Container(
                height: 65, width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Container(height: 15, width: double.maxFinite, color: Colors.grey[300]),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  const RatingBarWidget(rating: 0, size: 12, ratingCount: 0),
                  Row(children: [
                    Container(height: 15, width: 30, color: Colors.grey[300]),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Container(height: 10, width: 20, color: Colors.grey[300]),
                  ]),

                ]),
              ),

              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Icon(Icons.add, size: 25),
                Icon(
                  Icons.favorite_border,  size: 25,
                  color: Theme.of(context).disabledColor,
                ),
              ]),

            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Divider(color: hasDivider ? Theme.of(context).disabledColor : Colors.transparent),
        ),
      ],
    );
  }
}
