import 'package:dukan_store_app/features/notification/domain/models/notification_model.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:dukan_store_app/common/widgets/custom_image_widget.dart';

class NotificationDialogWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationDialogWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
      child:  SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            (notificationModel.imageFullUrl != null && notificationModel.imageFullUrl!.isNotEmpty) ? Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Theme.of(context).primaryColor.withOpacity(0.20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImageWidget(
                  isNotification: true,
                  image: '${notificationModel.imageFullUrl}', height: 200,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.contain,
                ),
              ),
            ) : const SizedBox(),
            SizedBox(height: (notificationModel.imageFullUrl != null && notificationModel.imageFullUrl!.isNotEmpty) ? Dimensions.paddingSizeLarge : 0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                notificationModel.title!,
                textAlign: TextAlign.center,
                style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                notificationModel.description!,
                textAlign: TextAlign.center,
                style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
