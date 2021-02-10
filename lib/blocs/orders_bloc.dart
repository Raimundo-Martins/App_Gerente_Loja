import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria { READY_FIRST, READY_LAST }

class OrdersBloc extends BlocBase {
  Firestore _firestore = Firestore.instance;
  SortCriteria _criteria;

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
      _sort();
    });
  }

  void _sort() {
    switch (_criteria) {
      case SortCriteria.READY_FIRST:
        _orders.sort((a, b) {
          int statusA = a.data['status'];
          int statusB = b.data['status'];

          if (statusA < statusB)
            return 1;
          else if (statusA > statusB)
            return -1;
          else
            return 0;
        });
        break;
      case SortCriteria.READY_LAST:
        _orders.sort((a, b) {
          int statusA = a.data['status'];
          int statusB = b.data['status'];

          if (statusA > statusB)
            return 1;
          else if (statusA < statusB)
            return -1;
          else
            return 0;
        });
        break;
    }
    _orderController.add(_orders);
  }

  void setOrderCriteria(SortCriteria criteria) {
    _criteria = criteria;
    _sort();
  }

  @override
  void dispose() {
    _orderController.close();
  }
}
