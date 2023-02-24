import 'dart:convert';

import '../helpers/network_helper.dart';

class PriceExchangeService {
  final NetworkHelper _networkHelper = NetworkHelper();

  // Retrieve bitcoin price.
  Future<double> price(String fiatCurrency) async {
    var uri = 'https://api.coinpaprika.com/v1/tickers/btc-bitcoin?quotes=$fiatCurrency';
    var responseBody = await _networkHelper.fetchData(uri);
    var price = jsonDecode(responseBody)['quotes'][fiatCurrency]['price'];
    return price;
  }

  // Retrieve bitcoin price.
  Future<double> percentChange(String fiatCurrency, String time) async {
    var uri = 'https://api.coinpaprika.com/v1/tickers/btc-bitcoin?quotes=$fiatCurrency';
    var responseBody = await _networkHelper.fetchData(uri);
    var percentChange = jsonDecode(responseBody)['quotes'][fiatCurrency][time];
    return percentChange;
  }
}
