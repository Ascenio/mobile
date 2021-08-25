import 'package:flutter/material.dart';

class NoTodosFound extends StatelessWidget {
  const NoTodosFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Looks like you have no todos yet 😎',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
