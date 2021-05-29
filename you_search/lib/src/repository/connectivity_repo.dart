import 'dart:io';

class ConnectivityRepo {
  Future<bool> checkConnectivity() async {
    // await InternetAddress.
    final response = await InternetAddress.lookup('google.com');
    if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      throw SocketException('Not Connected');
    }
  }
}
