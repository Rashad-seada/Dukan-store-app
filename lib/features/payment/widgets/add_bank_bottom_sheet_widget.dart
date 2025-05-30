import 'package:dukan_store_app/features/payment/controllers/payment_controller.dart';
import 'package:dukan_store_app/features/payment/domain/models/bank_info_body_model.dart';
import 'package:dukan_store_app/util/dimensions.dart';
import 'package:dukan_store_app/common/widgets/custom_button_widget.dart';
import 'package:dukan_store_app/common/widgets/custom_snackbar_widget.dart';
import 'package:dukan_store_app/features/payment/widgets/bank_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankBottomSheetWidget extends StatefulWidget {
  final String? bankName;
  final String? branchName;
  final String? holderName;
  final String? accountNo;
  const AddBankBottomSheetWidget({super.key, this.bankName, this.branchName, this.holderName, this.accountNo});

  @override
  State<AddBankBottomSheetWidget> createState() => _AddBankBottomSheetWidgetState();
}

class _AddBankBottomSheetWidgetState extends State<AddBankBottomSheetWidget> {

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _branchNameFocus = FocusNode();
  final FocusNode _holderNameFocus = FocusNode();
  final FocusNode _accountNoFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _bankNameController.text = widget.bankName ?? '';
    _branchNameController.text = widget.branchName ?? '';
    _holderNameController.text = widget.holderName ?? '';
    _accountNoController.text = widget.accountNo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
      ),
      child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [

        InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        BankFieldWidget(
          hintText: 'bank_name'.tr,
          controller: _bankNameController,
          focusNode: _bankNameFocus,
          nextFocus: _branchNameFocus,
          capitalization: TextCapitalization.words,
        ),

        BankFieldWidget(
          hintText: 'branch_name'.tr,
          controller: _branchNameController,
          focusNode: _branchNameFocus,
          nextFocus: _holderNameFocus,
          capitalization: TextCapitalization.words,
        ),

        BankFieldWidget(
          hintText: 'holder_name'.tr,
          controller: _holderNameController,
          focusNode: _holderNameFocus,
          nextFocus: _accountNoFocus,
          capitalization: TextCapitalization.words,
        ),

        BankFieldWidget(
          hintText: 'account_no'.tr,
          controller: _accountNoController,
          focusNode: _accountNoFocus,
          inputAction: TextInputAction.done,
        ),

        const SizedBox(height: Dimensions.paddingSizeSmall),

        GetBuilder<PaymentController>(builder: (paymentController) {
          return !paymentController.isLoading ? CustomButtonWidget(
            buttonText: widget.bankName != null ? 'update'.tr : 'add_bank'.tr,
            onPressed: () {
              String bankName = _bankNameController.text.trim();
              String branchName = _branchNameController.text.trim();
              String holderName = _holderNameController.text.trim();
              String accountNo = _accountNoController.text.trim();
              if(widget.bankName != null && bankName == widget.bankName && branchName == widget.branchName && holderName == widget.holderName
                  && accountNo == widget.accountNo) {
                showCustomSnackBar('change_something_to_update'.tr);
              }else if(bankName.isEmpty) {
                showCustomSnackBar('enter_bank_name'.tr);
              }else if(branchName.isEmpty) {
                showCustomSnackBar('enter_branch_name'.tr);
              }else if(holderName.isEmpty) {
                showCustomSnackBar('enter_holder_name'.tr);
              }else if(accountNo.isEmpty) {
                showCustomSnackBar('enter_account_no'.tr);
              }else {
                Get.find<PaymentController>().updateBankInfo(BankInfoBodyModel(
                  bankName: bankName, branch: branchName, holderName: holderName, accountNo: accountNo,
                ));
              }
            },
          ) : const Center(child: CircularProgressIndicator());
        }),

      ])),
    );
  }
}
