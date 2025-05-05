import 'package:crypto_coins_list/repositories/crypto_coins/models/models.dart';

class CryptoCoinDetails extends CryptoCoin {
  const CryptoCoinDetails({
    required super.name,
    required super.priceInUSD,
    required super.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.hight24Hour,
    required this.low24Hour,
});

  final String toSymbol;
  final DateTime lastUpdate;
  final double hight24Hour;
  final double low24Hour;

  @override
  List<Object> get props => super.props
    ..addAll([
      toSymbol,
      lastUpdate,
      hight24Hour,
      low24Hour,
    ]);
}