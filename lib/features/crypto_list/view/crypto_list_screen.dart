import 'dart:async';

import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: const Text('CryptoCurrenciesList'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TalkerScreen(
                  talker: GetIt.I<Talker>(),
                ),
              ),
            );
          }, icon: Icon(
              Icons.document_scanner_outlined),
          )
        ],
      ),
      body: RefreshIndicator(
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if(state is CryptoListLoaded) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 17),
                  itemCount: state.coinsList.length,
                  separatorBuilder:
                      (context, index) => Divider(color: theme.dividerColor),
                  itemBuilder: (context, i) {
                    final coin = state.coinsList[i];
                    return CryptoCoinTile(coin: coin);
                  },
                );
              }
              if(state is CryptoListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Something went wrong',
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text(
                        'Please, try again later',
                        style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          _cryptoListBloc.add(LoadCryptoList());
                        },
                        child: Text('Try again'),
                      )
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          })


    );
  }
}




