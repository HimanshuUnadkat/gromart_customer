import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controllers/live_tracking_controller.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
        init: LiveTrackingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: themeChange.getThem() ? AppThemeData.surfaceDark : AppThemeData.surface,
            appBar: AppBar(
              backgroundColor: themeChange.getThem() ? AppThemeData.surfaceDark : AppThemeData.surface,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: controller.isLoading.value
                ? Constant.loader()
                : Constant.selectedMapType == 'osm'
                    ? OSMFlutter(
                        controller: controller.mapOsmController,
                        osmOption: const OSMOption(
                          userTrackingOption: UserTrackingOption(
                            enableTracking: false,
                            unFollowUser: false,
                          ),
                          zoomOption: ZoomOption(
                            initZoom: 16,
                            minZoomLevel: 2,
                            maxZoomLevel: 19,
                            stepZoom: 1.0,
                          ),
                          roadConfiguration: RoadOption(
                            roadColor: Colors.yellowAccent,
                          ),
                        ),
                        onMapIsReady: (active) async {
                          if (active) {
                            controller.getArgument();
                            ShowToastDialog.closeLoader();
                          }
                        })
                    : Obx(
                        () => GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          mapType: MapType.terrain,
                          zoomControlsEnabled: false,
                          polylines: Set<Polyline>.of(controller.polyLines.values),
                          padding: const EdgeInsets.only(
                            top: 22.0,
                          ),
                          markers: Set<Marker>.of(controller.markers.values),
                          onMapCreated: (GoogleMapController mapController) {
                            controller.mapController = mapController;
                          },
                          initialCameraPosition: CameraPosition(
                            zoom: 15,
                            target: LatLng(
                                controller.driverUserModel.value.location!.latitude != null ? controller.driverUserModel.value.location!.latitude ?? 45.521563 : 45.521563,
                                controller.driverUserModel.value.location!.longitude != null ? controller.driverUserModel.value.location!.longitude ?? 45.521563 : 45.521563),
                          ),
                        ),
                      ),
          );
        });
  }
}
