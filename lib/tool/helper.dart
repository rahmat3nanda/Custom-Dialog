import 'package:flutter/material.dart';

class Helper {
  Future jumpToPage(BuildContext context, {@required Widget page}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future moveToPage(BuildContext context, {@required Widget page}) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void backToRootPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void showSnackbar(final key, final s) {
    key.currentState.showSnackBar(new SnackBar(
      content: new Text(s),
      duration: new Duration(milliseconds: 2000),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.blue,
        onPressed: () => key.currentState.hideSnackBar(),
      ),
    ));
  }
}
