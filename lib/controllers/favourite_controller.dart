import 'package:customer/constant/constant.dart';
import 'package:customer/models/favourite_item_model.dart';
import 'package:customer/models/favourite_model.dart';
import 'package:customer/models/product_model.dart';
import 'package:customer/models/vendor_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  RxBool favouriteRestaurant = true.obs;
  RxList<FavouriteModel> favouriteList = <FavouriteModel>[].obs;
  RxList<VendorModel> favouriteVendorList = <VendorModel>[].obs;

  RxList<FavouriteItemModel> favouriteItemList = <FavouriteItemModel>[].obs;
  RxList<ProductModel> favouriteFoodList = <ProductModel>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  getData() async {
    if (Constant.userModel != null) {
      await FireStoreUtils.getFavouriteRestaurant().then(
        (value) {
          favouriteList.value = value;
        },
      );

      await FireStoreUtils.getFavouriteItem().then(
        (value) {
          favouriteItemList.value = value;
        },
      );

      for (var element in favouriteList) {
        await FireStoreUtils.getVendorById(element.restaurantId.toString()).then(
          (value) {
            if (value != null) {
              favouriteVendorList.add(value);
            }
          },
        );
      }

      for (var element in favouriteItemList) {
        await FireStoreUtils.getProductById(element.productId.toString()).then(
          (value) {
            if (value != null) {
              favouriteFoodList.add(value);
            }
          },
        );
      }
    }

    isLoading.value = false;
  }
}
