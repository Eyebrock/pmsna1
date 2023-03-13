import 'package:flutter/material.dart';

class FlagosProvider with ChangeNotifier {
  bool _flagListPost = false;
  getflagListPost() => this._flagListPost;
  setFlagListPost() {
    this._flagListPost = !_flagListPost;
    notifyListeners();
  }
}
