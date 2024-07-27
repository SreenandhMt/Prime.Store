import 'package:equatable/equatable.dart';

class MainProductDataEntities extends Equatable{
  final List<String>? productUrls;
  final String? productName;
  final String? productAbout;
  final String? highlights;
  final String? productId;
  final String? sellerId;
  final int? colors;
  final String? size;

  const MainProductDataEntities({required this.productUrls, required this.productName, required this.productAbout, required this.highlights, required this.productId, required this.sellerId, required this.colors, required this.size});

  @override
  List<Object?> get props => throw UnimplementedError();
  
}