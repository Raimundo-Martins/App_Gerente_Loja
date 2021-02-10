import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;

  final _productController = BehaviorSubject<Map>();
  Stream<Map> get outProduct => _productController.stream;

  Map<String, dynamic> unsavedDado;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedDado = Map.of(product.data);
      unsavedDado['images'] = List.of(product.data['images']);
      unsavedDado['sizes'] = List.of(product.data['sizes']);
    } else {
      unsavedDado = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'sizes': []
      };
    }
    _productController.add(unsavedDado);
  }

  @override
  void dispose() {
    _productController.close();
  }
}
