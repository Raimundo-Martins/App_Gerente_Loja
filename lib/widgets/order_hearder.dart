import 'package:flutter/material.dart';

class OrderHearder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(''),
              Text(''),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(''),
            Text('', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        )
      ],
    );
  }
}
