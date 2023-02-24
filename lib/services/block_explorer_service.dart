import 'dart:convert';

import '../helpers/network_helper.dart';

class BlockExplorerService {
  final NetworkHelper _networkHelper = NetworkHelper();

  // Retrieve block height.
  Future<int> getBlockHeight() async {
    var uri = 'https://mempool.space/api/v1/blocks/';
    var responseBody = await _networkHelper.fetchData(uri);
    var blockHeight = jsonDecode(responseBody)[0]['height'];
    return blockHeight;
  }
}
