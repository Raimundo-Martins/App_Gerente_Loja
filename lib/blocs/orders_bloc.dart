import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {
  Firestore _firestore = Firestore.instance;

  final _orderController = BehaviorSubject<List>();
  Stream<List> get outOrders => _orderController.stream;

  List<DocumentSnapshot> _orders = [];

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String orderId = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == orderId);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == orderId);
            break;
        }
      });
      _orderController.add(_orders);
    });
  }

  @override
  void dispose() {
    _orderController.close();
  }
}
