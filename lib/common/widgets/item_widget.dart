import 'package:dukan_store_app/common/widgets/rating_bar_widget.dart';
import 'package:dukan_store_app/features/store/controllers/store_controller.dart';
import 'package:dukan_store_app/features/profile/controllers/profile_controller.dart';
import 'package:dukan_store_app/features/splash/controllers/splash_controller.dart';
import 'package:dukan_store_app/features/store/domain/models/item_model.dart';
import 'package:dukan_store_app/helper/date_converter_helper.dart';
import 'package:dukan_store_app/helper/price_converter_helper.dart';
import 'package:dukan_store_app/helper/route_helper.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/images.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:dukan_store_app/common/widgets/confirmation_dialog_widget.dart';
import 'package:dukan_store_app/common/widgets/custom_image_widget.dart';
import 'package:dukan_store_app/common/widgets/custom_snackbar_widget.dart';
import 'package:dukan_store_app/common/widgets/discount_tag_widget.dart';
import 'package:dukan_store_app/common/widgets/not_available_widget.dart';
import 'package:dukan_store_app/features/store/screens/item_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final int index;
  final int length;
  final bool inStore;
  final bool isCampaign;
  const ItemWidget({super.key, required this.item, required this.index,
   required this.length, this.inStore = false, this.isCampaign = false});

  @override
  Widget build(BuildContext context) {
    double? discount;
    String? discountType;
    bool isAvailable;
    discount = (item.storeDiscount == 0 || isCampaign) ? item.discount : item.storeDiscount;
    discountType = (item.storeDiscount == 0 || isCampaign) ? item.discountType : 'percent';
    isAvailable = DateConverterHelper.isAvailable(item.availableTimeStarts, item.availableTimeEnds);

    return InkWell(
      onTap: () => Get.toNamed(RouteHelper.getItemDetailsRoute(item), arguments: ItemDetailsScreen(item: item)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color:  Theme.of(context).cardColor,
          boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall,
            ),
            child: Row(children: [

              item.imageFullUrl != null ? Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  child: CustomImageWidget(
                    image: '${item.imageFullUrl}',
                    height: 120, width: 100, fit: BoxFit.cover,
                  ),
                ),
                DiscountTagWidget(
                  discount: discount, discountType: discountType,
                  freeDelivery: false,
                ),
                isAvailable ? const SizedBox() : const NotAvailableWidget(isStore: false),
              ]) : const SizedBox(),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                    Text(
                      item.name ?? '', textAlign: TextAlign.start,
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: item.imageFullUrl == null ? Dimensions.paddingSizeExtraSmall : 0),

                    item.imageFullUrl == null ? Text(
                      '(${discount! > 0 ? '$discount${discountType == 'percent' ? '%' : Get.find<SplashController>().configModel!.currencySymbol} ${'off'.tr}' : 'free_delivery'.tr})',
                      style: robotoMedium.copyWith(color: Colors.green, fontSize: Dimensions.fontSizeExtraSmall),
                    ) : const SizedBox(),
                  ]),
                  SizedBox(height: item.imageFullUrl != null ? Dimensions.paddingSizeExtraSmall : 0),

                  Row(children: [
                    RatingBarWidget(
                      rating: item.avgRating, size: 12,
                      ratingCount: item.ratingCount,
                    ),

                    item.imageFullUrl == null && !isAvailable ? Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        '(${'not_available_now'.tr})', textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(color: Colors.red, fontSize: Dimensions.fontSizeExtraSmall),
                      ),
                    ) : const SizedBox(),
                  ]),
                  const SizedBox(height: 2),

                  Row(children: [

                    Text(
                      PriceConverterHelper.convertPrice(item.price, discount: discount, discountType: discountType),
                      style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                    SizedBox(width: discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),

                    discount > 0 ? Text(
                      PriceConverterHelper.convertPrice(item.price),
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).disabledColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ) : const SizedBox(),

                  ]),

                ]),
              ),

              IconButton(
                onPressed: () {
                  if(Get.find<ProfileController>().profileModel!.stores![0].itemSection!) {
                    Get.find<StoreController>().getItemDetails(item.id!).then((itemDetails) {
                      if(itemDetails != null){
                        Get.toNamed(RouteHelper.getAddItemRoute(itemDetails));
                      }
                    });
                  }else {
                    showCustomSnackBar('this_feature_is_blocked_by_admin'.tr);
                  }
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
              ),

              IconButton(
                onPressed: () {
                  if(Get.find<ProfileController>().profileModel!.stores![0].itemSection!) {
                    Get.dialog(ConfirmationDialogWidget(
                      icon: Images.warning, description: 'are_you_sure_want_to_delete_this_product'.tr,
                      onYesPressed: () => Get.find<StoreController>().deleteItem(item.id),
                    ));
                  }else {
                    showCustomSnackBar('this_feature_is_blocked_by_admin'.tr);
                  }
                },
                icon: const Icon(Icons.delete_forever, color: Colors.red),
              ),

            ]),
          )),
        ]),
      ),
    );
  }
}
