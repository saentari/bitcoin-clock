import 'dart:convert';

import '../constants/url.dart';
import '../helpers/network_helper.dart';

class PriceService {
  final NetworkHelper _networkHelper = NetworkHelper();

  // Retrieve bitcoin price.
  Future<int> getPrice(String fiatCurrency) async {
    final responseBody = await _networkHelper.fetchData(mempoolPrices);
    final price = jsonDecode(responseBody)[fiatCurrency];
    return price;
  }
}
