import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dukan_store_app/api/api_client.dart';
import 'package:dukan_store_app/features/language/domain/repositories/language_repository_interface.dart';
import 'package:dukan_store_app/features/profile/controllers/profile_controller.dart';
import 'package:dukan_store_app/util/app_constants.dart';

class LanguageRepository implements LanguageRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LanguageRepository({required this.apiClient, required this.sharedPreferences});

  @override
  void updateHeader(Locale locale) {
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.token), locale.languageCode,
      Get.find<ProfileController>().profileModel != null ? Get.find<ProfileController>().profileModel!.stores![0].module!.id : null,
      sharedPreferences.getString(AppConstants.type),
    );
  }

  @override
  Locale getLocaleFromSharedPref() {
    return Locale(sharedPreferences.getString(AppConstants.languageCode) ?? AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants.countryCode) ?? AppConstants.languages[0].countryCode);
  }

  @override
  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.countryCode, locale.countryCode!);
  }

  @override
  void saveCacheLanguage(Locale locale) {
    sharedPreferences.setString(AppConstants.cacheLanguageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.cacheCountryCode, locale.countryCode!);
  }

  @override
  Locale getCacheLocaleFromSharedPref() {
    return Locale(sharedPreferences.getString(AppConstants.cacheLanguageCode) ?? AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants.cacheCountryCode) ?? AppConstants.languages[0].countryCode);
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(int? id) {
    throw UnimplementedError();
  }

  @override
  Future getList() {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body) {
    throw UnimplementedError();
  }

}