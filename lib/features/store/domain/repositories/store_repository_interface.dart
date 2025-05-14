import 'package:image_picker/image_picker.dart';
import 'package:dukan_store_app/features/profile/domain/models/profile_model.dart';
import 'package:dukan_store_app/features/store/domain/models/band_model.dart';
import 'package:dukan_store_app/features/store/domain/models/review_model.dart';
import 'package:dukan_store_app/interface/repository_interface.dart';
import 'package:dukan_store_app/features/store/domain/models/item_model.dart';

abstract class StoreRepositoryInterface<T> extends RepositoryInterface<Schedules> {
  Future<dynamic> getItemList(String offset, String type);
  Future<dynamic> getPendingItemList(String offset, String type);
  Future<dynamic> getPendingItemDetails(int itemId);
  Future<dynamic> getAttributeList(Item? item);
  Future<dynamic> updateStore(Store store, XFile? logo, XFile? cover, String min, String max, String type, List<Translation> translation);
  Future<dynamic> addItem(Item item, XFile? image, List<XFile> images, List<String> savedImages, Map<String, String> attributes, bool isAdd, String tags, String nutrition, String allergicIngredients, String genericName);
  Future<dynamic> deleteItem(int? itemID, bool pendingItem);
  Future<List<ReviewModel>?> getStoreReviewList(int? storeID, String? searchText);
  Future<dynamic> getItemReviewList(int? itemID);
  Future<dynamic> updateItemStatus(int? itemID, int status);
  Future<dynamic> getUnitList();
  Future<dynamic> updateRecommendedProductStatus(int? productID, int status);
  Future<dynamic> updateOrganicProductStatus(int? productID, int status);
  Future<dynamic> updateAnnouncement(int status, String announcement);
  Future<List<BrandModel>?> getBrandList();
  Future<bool> updateReply(int reviewID, String reply);
  Future<List<String?>?> getNutritionSuggestionList();
  Future<List<String?>?> getAllergicIngredientsSuggestionList();
  Future<List<String?>?> getGenericNameSuggestionList();
}