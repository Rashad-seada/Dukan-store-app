import 'package:dukan_store_app/features/addon/domain/repositories/addon_repository_interface.dart';
import 'package:dukan_store_app/features/addon/domain/services/addon_service_interface.dart';
import 'package:dukan_store_app/features/store/domain/models/item_model.dart';

class AddonService implements AddonServiceInterface {
  final AddonRepositoryInterface addonRepositoryInterface;
  AddonService({required this.addonRepositoryInterface});

  @override
  Future<List<AddOns>?> getAddonList() async {
    return await addonRepositoryInterface.getList();
  }

  @override
  Future<bool> addAddon(AddOns addonModel) async {
    return await addonRepositoryInterface.add(addonModel);
  }

  @override
  Future<bool> updateAddon(Map<String, dynamic> body) async {
    return await addonRepositoryInterface.update(body);
  }

  @override
  Future<bool> deleteAddon(int? addonID) async {
    return await addonRepositoryInterface.delete(addonID);
  }

  @override
  List<int?> prepareAddonIds(List<AddOns> addonList) {
    List<int?> addonsIds = [];
    for (var addon in addonList) {
      addonsIds.add(addon.id);
    }
    return addonsIds;
  }

}