import 'package:dukan_store_app/features/pos/controllers/pos_controller.dart';
import 'package:dukan_store_app/features/profile/controllers/profile_controller.dart';
import 'package:dukan_store_app/features/store/domain/models/item_model.dart';
import 'package:dukan_store_app/features/profile/domain/models/profile_model.dart';
import 'package:dukan_store_app/helper/date_converter_helper.dart';
import 'package:dukan_store_app/helper/price_converter_helper.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:dukan_store_app/common/widgets/custom_button_widget.dart';
import 'package:dukan_store_app/common/widgets/custom_image_widget.dart';
import 'package:dukan_store_app/common/widgets/custom_snackbar_widget.dart';
import 'package:dukan_store_app/common/widgets/text_field_widget.dart';
import 'package:dukan_store_app/features/pos/widgets/pos_product_widget.dart';
import 'package:dukan_store_app/features/pos/widgets/product_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).textTheme.bodyLarge!.color,
          onPressed: () => Get.back(),
        ),
        title: TypeAheadField(
          builder: (context, controller, focusNode) => TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            autofocus: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'search_item'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: robotoRegular.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await Get.find<PosController>().searchItem(pattern);
          },
          itemBuilder: (context, Item suggestion) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImageWidget(
                    image: '${suggestion.imageFullUrl}',
                    height: 40, width: 40, fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(suggestion.name!, maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                    )),
                    Text(PriceConverterHelper.convertPrice(suggestion.price), style: robotoRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeSmall,
                    )),
                  ]),
                ),
              ]),
            );
          },
          onSelected: (Item suggestion) {
            _searchController.text = '';
            Get.bottomSheet(ItemBottomSheetWidget(item: suggestion));
          },
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),

      body: GetBuilder<PosController>(
        builder: (posController) {
          List<List<AddOns>> addOnsList = [];
          List<bool> availableList = [];
          double itemPrice = 0;
          double addOns = 0;
          double? discount = 0;
          double tax = 0;
          double orderAmount = 0;
          Store? store = Get.find<ProfileController>().profileModel != null
              ? Get.find<ProfileController>().profileModel!.stores![0] : null;

          if(store != null) {
            for (var cartModel in posController.cartList) {

              List<AddOns> addOnList = [];
              for (var addOnId in cartModel.addOnIds!) {
                for(AddOns addOns in cartModel.item!.addOns!) {
                  if(addOns.id == addOnId.id) {
                    addOnList.add(addOns);
                    break;
                  }
                }
              }
              addOnsList.add(addOnList);

              availableList.add(DateConverterHelper.isAvailable(cartModel.item!.availableTimeStarts, cartModel.item!.availableTimeEnds));

              for(int index=0; index<addOnList.length; index++) {
                addOns = addOns + (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
              }
              itemPrice = itemPrice + (cartModel.price! * cartModel.quantity!);
              double? dis = (store.discount != null
                  && DateConverterHelper.isAvailable(store.discount!.startTime, store.discount!.endTime, isoTime: true))
                  ? store.discount!.discount : cartModel.item!.discount;
              String? disType = (store.discount != null
                  && DateConverterHelper.isAvailable(store.discount!.startTime, store.discount!.endTime, isoTime: true))
                  ? 'percent' : cartModel.item!.discountType;
              discount = discount! + ((cartModel.price! - PriceConverterHelper.convertWithDiscount(cartModel.price, dis, disType)!) * cartModel.quantity!);
            }

            if (store.discount != null) {
              if (store.discount!.maxDiscount != 0 && store.discount!.maxDiscount! < discount!) {
                discount = store.discount!.maxDiscount;
              }
              if (store.discount!.minPurchase != 0 && store.discount!.minPurchase! > (itemPrice + addOns)) {
                discount = 0;
              }
            }
            orderAmount = (itemPrice - discount!) + addOns;
            tax = PriceConverterHelper.calculation(orderAmount, store.tax, 'percent', 1);
          }

          double subTotal = itemPrice + addOns;
          double total = subTotal - discount+ tax;

          if(posController.discount != -1) {
            discount = posController.discount;
          }

          _discountController.text = discount.toString();
          _taxController.text = tax.toString();

          return posController.cartList.isNotEmpty ? Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall), physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: SizedBox(
                      width: 1170,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        // Product
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: posController.cartList.length,
                          itemBuilder: (context, index) {
                            return PosProductWidget(
                              cart: posController.cartList[index], cartIndex: index,
                              addOns: addOnsList[index], isAvailable: availableList[index],
                            );
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        // Total
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('item_price'.tr, style: robotoRegular),
                          Text(PriceConverterHelper.convertPrice(itemPrice), style: robotoRegular),
                        ]),
                        const SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('addons'.tr, style: robotoRegular),
                          Text('(+) ${PriceConverterHelper.convertPrice(addOns)}', style: robotoRegular),
                        ]),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('subtotal'.tr, style: robotoMedium),
                          Text(PriceConverterHelper.convertPrice(subTotal), style: robotoMedium),
                        ]),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Row(children: [
                          Expanded(child: Text('discount'.tr, style: robotoRegular)),
                          SizedBox(
                            width: 70,
                            child: TextFieldWidget(
                              title: false,
                              controller: _discountController,
                              onSubmit: (text) => posController.setDiscount(text),
                              inputAction: TextInputAction.done,
                            ),
                          ),
                          Text('(-) ${PriceConverterHelper.convertPrice(discount)}', style: robotoRegular),
                        ]),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('vat_tax'.tr, style: robotoRegular),
                          Text('(+) ${PriceConverterHelper.convertPrice(tax)}', style: robotoRegular),
                        ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            'total_amount'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            PriceConverterHelper.convertPrice(total),
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                          ),
                        ]),

                      ]),
                    ),
                  ),
                ),
              ),

              Container(
                width: 1170,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CustomButtonWidget(buttonText: 'order_now'.tr, onPressed: () {
                  if(availableList.contains(false)) {
                    showCustomSnackBar('one_or_more_product_unavailable'.tr);
                  } else {

                  }
                }),
              ),

            ],
          ) : Center(child: Text('no_item_available'.tr));
        },
      ),
    );
  }
}
