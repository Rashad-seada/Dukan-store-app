import 'package:dukan_store_app/interface/repository_interface.dart';

abstract class SplashRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getConfigData();
  Future<bool> initSharedData();
  bool showIntro();
  void setIntro(bool intro);
  Future<bool> removeSharedData();
}