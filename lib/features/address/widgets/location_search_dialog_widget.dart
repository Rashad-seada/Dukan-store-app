import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dukan_store_app/features/address/controllers/address_controller.dart';
import 'package:dukan_store_app/features/address/domain/models/prediction_model.dart';
import 'package:dukan_store_app/util/dimensions.dart';

class LocationSearchDialogWidget extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialogWidget({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scrollable(viewportBuilder: (context, viewPostOffset) => Container(
      margin: const EdgeInsets.only(top:  0),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        child: SizedBox(width: context.width, child: TypeAheadField(
          builder: (context, controller, focusNode) => TextField(
            controller: searchController,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: 'search_location'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await Get.find<AddressController>().searchLocation(context, pattern);
          },
          itemBuilder: (context, PredictionModel suggestion) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Row(children: [
                const Icon(Icons.location_on),
                Expanded(
                  child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                  )),
                ),
              ]),
            );
          },
          onSelected: (PredictionModel suggestion) async {
            Position position = await Get.find<AddressController>().setSuggestedLocation(suggestion.placeId, suggestion.description, mapController);
            Get.back(result: position);
          },
        )),
      ),
    ));
  }
}
