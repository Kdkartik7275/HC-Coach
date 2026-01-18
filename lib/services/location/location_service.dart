import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Converts latitude & longitude into a readable address
  Future<String> getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return '';
      }

      final Placemark place = placemarks.first;

      // You can customize the format as needed
      final String address = [
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.postalCode,
        place.country,
      ].where((e) => e != null && e.isNotEmpty).join(', ');

      return address;
    } catch (e) {
      return '';
    }
  }
}
