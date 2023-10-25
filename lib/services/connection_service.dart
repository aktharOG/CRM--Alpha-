import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/main.dart';
import 'package:crm_new/src/connection/network_connection_screen.dart';

class ConnectionService {
  initLiveConnectionUpdates() async {
    print("listening network connection.................");
// final connectivityResult = await (Connectivity().checkConnectivity()
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      } else if (result == ConnectivityResult.ethernet) {
        // I am connected to a ethernet network.
      } else if (result == ConnectivityResult.vpn) {
        // I am connected to a vpn network.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
      } else if (result == ConnectivityResult.bluetooth) {
        // I am connected to a bluetooth.
      } else if (result == ConnectivityResult.other) {
        // I am connected to a network which is not in the above mentioned networks.
      } else if (result == ConnectivityResult.none) {
        // I am not connected to any network.
        push(navigatorKey.currentState!.context,
            const NetworkConnectionScreen());
      }
    });
  }
}
