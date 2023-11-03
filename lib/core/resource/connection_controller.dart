import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionController extends GetxController {

  @override
  onInit() async {
    startCheckInternet();
    backgroundCheckInternet();
    super.onInit();


  }

  var isConnected = false.obs;

  Future<bool> startCheckInternet() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.ethernet ||
        connection == ConnectivityResult.wifi) {

      isConnected.value = true;
    } else {
      // print('not connected');

      isConnected.value = false;
    }
    print(isConnected);
    return isConnected.value;
  }

  Future<bool> backgroundCheckInternet() async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.mobile ||
          status == ConnectivityResult.ethernet ||
          status == ConnectivityResult.wifi) {
        isConnected.value = true;
        print('changed true');
      } else {
        isConnected.value = false;
        print('changed false');
      }
    });
    return isConnected.value;
  }
}
