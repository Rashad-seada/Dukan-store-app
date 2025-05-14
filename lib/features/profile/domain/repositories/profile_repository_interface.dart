import 'package:image_picker/image_picker.dart';
import 'package:dukan_store_app/features/profile/domain/models/profile_model.dart';
import 'package:dukan_store_app/interface/repository_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getProfileInfo();
  Future<dynamic> updateProfile(ProfileModel userInfoModel, XFile? data, String token);
  Future<dynamic> deleteVendor();
  updateHeader(int? moduleID);
}