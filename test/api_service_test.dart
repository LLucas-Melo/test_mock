import 'dart:async';

import 'package:Mock/api_service.dart';
import 'package:Mock/produto.dart';
import 'package:test/test.dart';

import 'package:uno/uno.dart';

class UnoMock implements Uno {
  final bool withError;

  UnoMock([this.withError = false]);
  @override
  Future<Response> get(String url,
      {Duration? timeout,
      Map<String, String> params = const {},
      Map<String, String> headers = const {},
      ResponseType responseType = ResponseType.json,
      DownloadCallback? onDownloadProgress,
      ValidateCallback? validateStatus}) async {
    if (withError) {
      throw UnoError('error');
    }
    return Response(
        headers: headers,
        request: Request(
            headers: {}, method: '', timeout: Duration.zero, uri: Uri.base),
        status: 200,
        data: productListJson);
  }

  @override
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  test('deve retornar uma lista de Product', () async {
    final uno = UnoMock();
    final service = ApiServices(uno);

    expect(
        service.getProducts(),
        completion([
          Product(id: 1, title: 'title', price: 12.0),
          Product(id: 2, title: 'title2', price: 3.0)
        ]));
  });

  test(
      'Deve retornar uma lista de Product'
      'vazia quando houver uma falha', () {
    final uno = UnoMock(true);
    final service = ApiServices(uno);

    expect(service.getProducts(), completion([]));
  });
}

final productListJson = [
  {
    'id': 1,
    'title': 'title',
    'price': 12.0,
  },
  {
    'id': 2,
    'title': 'title2',
    'price': 3.0,
  },
];
