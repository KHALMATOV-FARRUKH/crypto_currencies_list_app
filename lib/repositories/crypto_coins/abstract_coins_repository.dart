// import 'package:crypto_currencies_list_app/repositories/models/crypto_coin.dart';

import 'models/crypto_coin.dart';

abstract class AbstractCoinsRepository {

  Future<List<CryptoCoin>> getCoinsList();
}