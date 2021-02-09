import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white);

    return ListTile(
      title: Text('Title', style: textStyle),
      subtitle: Text('subTitle', style: textStyle),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Pedidos: 0', style: textStyle),
          Text('', style: textStyle),
        ],
      ),
    );
  }
}
