import 'dart:convert';

import '../constants/url.dart';
import '../helpers/network_helper.dart';

class BlockExplorerService {
  final NetworkHelper _networkHelper = NetworkHelper();

  // Retrieve block height.
  Future<int> getBlockHeight() async {
    final responseBody = await _networkHelper.fetchData(mempoolBlockHeigh);
    final blockHeight = jsonDecode(responseBody)[0]['height'];
    return blockHeight;
  }
}
