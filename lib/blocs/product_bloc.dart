import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;

  final _productController = BehaviorSubject<Map>();
  Stream<Map> get outProduct => _productController.stream;

  final _loadingController = BehaviorSubject<bool>();
  Stream<bool> get outLoading => _loadingController.stream;

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

  void saveImages(List images) {
    unsavedDado['images'] = images;
  }

  void saveTitle(String title) {
    unsavedDado['title'] = title;
  }

  void saveDescription(String description) {
    unsavedDado['description'] = description;
  }

  void savePrice(String price) {
    unsavedDado['price'] = double.parse(price);
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    await Future.delayed(Duration(seconds: 3));
    _loadingController.add(false);
    return true;
  }

  @override
  void dispose() {
    _productController.close();
    _loadingController.close();
  }
}
