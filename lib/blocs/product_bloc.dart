import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;

  final _productController = BehaviorSubject<Map>();
  Stream<Map> get outProduct => _productController.stream;

  final _loadingController = BehaviorSubject<bool>();
  Stream<bool> get outLoading => _loadingController.stream;

  final _createdController = BehaviorSubject<bool>();
  Stream<bool> get outCreated => _createdController.stream;

  Map<String, dynamic> unsavedDado;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedDado = Map.of(product.data);
      unsavedDado['images'] = List.of(product.data['images']);
      unsavedDado['sizes'] = List.of(product.data['sizes']);

      _createdController.add(true);
    } else {
      unsavedDado = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'sizes': []
      };
      _createdController.add(false);
    }
    _productController.add(unsavedDado);
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedDado['images'].length; i++) {
      if (unsavedDado['images'][i] is String) continue;
      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedDado['images'][i]);

      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      unsavedDado['images'][i] = downloadUrl;
    }
  }

  void saveImages(List images) {
    unsavedDado['images'] = images;
  }

  void saveSizes(List sizes) {
    unsavedDado['sizes'] = sizes;
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

  // ignore: missing_return
  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      if (product != null) {
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedDado);
      } else {
        DocumentReference reference = await Firestore.instance
            .collection('products')
            .document(categoryId)
            .collection('items')
            .add(Map.from(unsavedDado)..remove('images'));

        await _uploadImages(reference.documentID);
        await reference.updateData(unsavedDado);

        _createdController.add(true);
        _loadingController.add(false);
        return true;
      }
    } catch (erro) {
      _loadingController.add(false);
      return false;
    }
  }

  void deleteProduct() {
    product.reference.delete();
  }

  @override
  void dispose() {
    _productController.close();
    _loadingController.close();
    _createdController.close();
  }
}
