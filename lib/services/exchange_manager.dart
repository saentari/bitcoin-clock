import 'dart:convert';

import 'network_helper.dart';

class ExchangeManager {
  final NetworkHelper _networkHelper = NetworkHelper();

  // Retrieve bitcoin price.
  Future<double> price(String fiatCurrency) async {
    var uri =
        'https://api.coinpaprika.com/v1/tickers/btc-bitcoin?quotes=$fiatCurrency';
    var responseBody = await _networkHelper.fetchData(uri);
    var price = jsonDecode(responseBody)['quotes'][fiatCurrency]['price'];
    return price;
  }
}
