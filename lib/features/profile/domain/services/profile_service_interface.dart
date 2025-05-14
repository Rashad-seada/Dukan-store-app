import 'package:image_picker/image_picker.dart';
import 'package:dukan_store_app/common/models/response_model.dart';
import 'package:dukan_store_app/features/profile/domain/models/profile_model.dart';

abstract class ProfileServiceInterface {
  Future<ProfileModel?> getProfileInfo();
  Future<bool> updateProfile(ProfileModel userInfoModel, XFile? data, String token);
  Future<ResponseModel> deleteVendor();
  updateHeader(int? moduleID);
}