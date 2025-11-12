import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1983805597299153/9020560222';
    } else if (Platform.isIOS) {
      return 'Your IOS UNIT ID';
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }
}
