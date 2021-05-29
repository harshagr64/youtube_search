import 'package:flutter/material.dart';

class CenteredMesaage extends StatelessWidget {
  final String message;
  final IconData iconData;

  const CenteredMesaage({
    Key key,
    @required this.message,
    @required this.iconData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Opacity(
      opacity: 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 40,
          ),
          Text(
            '$message',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ));
  }
}
