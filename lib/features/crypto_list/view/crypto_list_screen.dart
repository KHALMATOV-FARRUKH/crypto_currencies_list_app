import 'dart:async';

import 'package:crypto_currencies_list_app/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_currencies_list_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Crypto Currencies List")),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {

            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.coinsList.length,
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Something went wrong"),
                    const Text("Please try again later"),
                    const SizedBox(height: 30),
                    TextButton(onPressed: () {
                      _cryptoListBloc.add(LoadCryptoList());
                    }, child: const Text("Try Again")),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),

      // (_cryptoCoinsList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         padding: const EdgeInsets.only(top: 10),
      //         separatorBuilder: (context, index) => const Divider(),
      //         itemCount: _cryptoCoinsList!.length,
      //         itemBuilder: (context, i) {
      //           final coin = _cryptoCoinsList![i];
      //           return CryptoCoinTile(coin: coin);
      //         },
      //       ),
    );
  }
}
