import 'package:dukan_store_app/features/order/domain/models/order_model.dart';
import 'package:dukan_store_app/helper/date_converter_helper.dart';
import 'package:dukan_store_app/helper/route_helper.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final bool hasDivider;
  final bool isRunning;
  final bool showStatus;
  const OrderWidget({super.key, required this.orderModel, required this.hasDivider, required this.isRunning, this.showStatus = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouteHelper.getOrderDetailsRoute(orderModel.id), /*arguments: OrderDetailsScreen(
        orderModel: orderModel, isRunningOrder: isRunning,
      )*/),
      child: Column(children: [

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${'order_id'.tr}: #${orderModel.id}', style: robotoMedium),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Row(children: [
                Text(
                  DateConverterHelper.dateTimeStringToDateTime(orderModel.createdAt!),
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                ),
                Container(
                  height: 10, width: 1, color: Theme.of(context).disabledColor,
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                ),
                Text(
                  orderModel.orderType!.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                ),
              ]),
            ])),

            showStatus ? Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  return Text(
                    orderModel.orderStatus!.tr,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                  );
                }
              ),
            ) : Text(
              '${orderModel.detailsCount} ${orderModel.detailsCount! < 2 ? 'item'.tr : 'items'.tr}',
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            ),

            showStatus ? const SizedBox() : Icon(Icons.keyboard_arrow_right, size: 30, color: Theme.of(context).primaryColor),

          ]),
        ),

        hasDivider ? Divider(color: Theme.of(context).disabledColor) : const SizedBox(),

      ]),
    );
  }
}
