import 'package:get/get.dart';
import 'package:dukan_store_app/features/business/domain/models/business_plan_body.dart';
import 'package:dukan_store_app/features/business/domain/services/business_service_interface.dart';

class BusinessController extends GetxController implements GetxService {
  final BusinessServiceInterface businessServiceInterface;
  BusinessController({required this.businessServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _businessPlanStatus = 'business';
  String get businessPlanStatus => _businessPlanStatus;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  bool _freeTrialExpand = false;
  bool get freeTrialExpand => _freeTrialExpand;

  void changeDigitalPaymentName(String? name, {bool canUpdate = true}){
    _digitalPaymentName = name;
    if(canUpdate) {
      update();
    }
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  Future<void> submitBusinessPlan({required int storeId, required int? packageId})async {
    _isLoading = true;
    update();

    if(packageId != null) {
      _businessPlanStatus = 'payment';
      _businessPlanStatus = await businessServiceInterface.processesBusinessPlan(_businessPlanStatus, _paymentIndex, storeId, _digitalPaymentName, packageId);
    } else {
      String businessPlan = 'commission';
      await businessServiceInterface.setUpBusinessPlan(BusinessPlanBody(businessPlan: businessPlan, storeId: storeId.toString()), _digitalPaymentName, businessPlanStatus, storeId, packageId);
    }

    _isLoading = false;
    update();
  }

  Future<void> changeFreeTrialExpandStatus() async {
    _freeTrialExpand = !_freeTrialExpand;
    update();
  }

}