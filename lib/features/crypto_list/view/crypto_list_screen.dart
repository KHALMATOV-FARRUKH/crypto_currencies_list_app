import 'package:crypto_currencies_list_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:crypto_currencies_list_app/repositories/models/crypto_coin.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Crypto Currencies List")),
      ),
      body: (_cryptoCoinsList == null)
          ? const Center(child:  CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _cryptoCoinsList!.length,
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];
                return CryptoCoinTile(coin: coin);
              },
            ),

    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
    setState(() {});
  }
}
