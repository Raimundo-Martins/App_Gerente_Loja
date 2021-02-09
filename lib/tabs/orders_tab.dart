import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemBuilder: (context, index) => OrderTile(),
        itemCount: 0,
      ),
    );
  }
}
