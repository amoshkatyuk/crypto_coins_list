import 'dart:async';
import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();

  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  talker.info(app.options.projectId);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      )
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
          () => CryptoCoinsRepository(dio: dio));

  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
        () => runApp(const CryptoCurrenciesListApp()),
        (error, stack) => GetIt.I<Talker>().handle(error, stack),
  );
}