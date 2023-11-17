// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Mock/produto.dart';
import 'package:uno/uno.dart';

class ApiServices {
  final Uno uno;
  ApiServices(
    this.uno,
  );

  Future<List<Product>> getProducts() async {
    try {
      final response = await uno.get('/product');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on UnoError {
      return [];
    }
  }
}
