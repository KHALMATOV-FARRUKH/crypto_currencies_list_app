import 'dart:async';

import 'package:crypto_currencies_list_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/crypto_coins/models/crypto_coin.dart';

part 'crypto_list_event.dart';

part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        emit(CryptoListLoading());
        final coinsList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      }
      finally{
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
}
