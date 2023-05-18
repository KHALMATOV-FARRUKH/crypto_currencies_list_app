import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins.dart';
// import 'package:crypto_currencies_list_app/repositories/models/crypto_coin.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{

  CryptoCoinsRepository({required this.dio});


  final Dio dio;


  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,ATX,B2B,BCDN&tsyms=USD");

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map(
      (e) {
        final usdData =
            (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
        final prise = usdData['PRICE'];
        final imageUrl = usdData['IMAGEURL'];
        return CryptoCoin(
          name: e.key,
          priceInUSD: prise,
          imageUrl: 'https://www.cryptocompare.com/$imageUrl',
        );
      },
    ).toList();
    return cryptoCoinsList;
  }
}
