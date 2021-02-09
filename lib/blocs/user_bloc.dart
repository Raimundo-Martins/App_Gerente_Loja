import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

class UserBloc extends BlocBase {
  final _userController = BehaviorSubject<List>();
  Stream<List> get outUsers => _userController.stream;

  Map<String, Map<String, dynamic>> _users = {};
  Firestore _firestore = Firestore.instance;

  UserBloc() {
    _addUserListener();
  }

  void _addUserListener() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String uid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            _userController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unSubscriptionToOrders(uid);
            _userController.add(_users.values.toList());
            break;
          default:
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]['subscription'] = _firestore
        .collection('users')
        .document(uid)
        .collection('orders')
        .snapshots()
        .listen(
      (orders) async {
        int numOrders = orders.documents.length;
        double money = 0.0;

        for (DocumentSnapshot snapshot in orders.documents) {
          DocumentSnapshot order = await _firestore
              .collection('orders')
              .document(snapshot.documentID)
              .get();

          if (order.data == null) continue;
          money += order.data['totalPrice'];
        }
        _users[uid].addAll({'money': money, 'orders': numOrders});
        _userController.add(_users.values.toList());
      },
    );
  }

  void _unSubscriptionToOrders(String uid) {
    _users[uid]['subscription'].cancel();
  }

  List<Map<String, dynamic>> _filter(String search) {
    List<Map<String, dynamic>> filteredUsers =
        List.from(_users.values.toList());
    filteredUsers.retainWhere(
        (user) => user['nome'].toUpperCase().contains(search.toUpperCase()));
    return filteredUsers;
  }

  void onChangedSearch(String search) {
    if (search.trim().isEmpty) {
      _userController.add(_users.values.toList());
    } else {
      _userController.add(_filter(search.trim()));
    }
  }

  @override
  void dispose() {
    _userController.close();
  }
}
