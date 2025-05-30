import 'package:image_picker/image_picker.dart';
import 'package:dukan_store_app/common/models/response_model.dart';
import 'package:dukan_store_app/features/profile/domain/models/profile_model.dart';
import 'package:dukan_store_app/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:dukan_store_app/features/profile/domain/services/profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  final ProfileRepositoryInterface profileRepositoryInterface;
  ProfileService({required this.profileRepositoryInterface});

  @override
  Future<ProfileModel?> getProfileInfo() async {
    return await profileRepositoryInterface.getProfileInfo();
  }

  @override
  Future<bool> updateProfile(ProfileModel userInfoModel, XFile? data, String token) async {
    return await profileRepositoryInterface.updateProfile(userInfoModel, data, token);
  }

  @override
  Future<ResponseModel> deleteVendor() async {
    return await profileRepositoryInterface.deleteVendor();
  }

  @override
  void updateHeader(int? moduleID) {
    profileRepositoryInterface.updateHeader(moduleID);
  }

}