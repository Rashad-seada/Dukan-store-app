import 'package:dukan_store_app/features/payment/domain/models/withdraw_model.dart';
import 'package:dukan_store_app/helper/date_converter_helper.dart';
import 'package:dukan_store_app/helper/price_converter_helper.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawWidget extends StatelessWidget {
  final WithdrawModel withdrawModel;
  final bool showDivider;
  const WithdrawWidget({super.key, required this.withdrawModel, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
        child: Row(children: [

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(PriceConverterHelper.convertPrice(withdrawModel.amount), style: robotoMedium),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Text('${'transferred_to'.tr} ${withdrawModel.bankName}', style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
            )),

          ])),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

            Text(
              DateConverterHelper.dateTimeStringToDateTime(withdrawModel.requestedAt!),
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Text(withdrawModel.status!.tr, style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: withdrawModel.status == 'Approved' ? Theme.of(context).primaryColor : withdrawModel.status == 'Denied'
                  ? Theme.of(context).colorScheme.error : Colors.blue,
            )),

          ]),

        ]),
      ),

      Divider(color: showDivider ? Theme.of(context).disabledColor : Colors.transparent),

    ]);
  }
}
