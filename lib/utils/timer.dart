import 'dart:async';

setTimeout(milliseconds, callback) {
  new Timer(new Duration(milliseconds: milliseconds), () {
    if (callback != null) {
      callback();
    }
  });
}

class AppTimer {
  static setTimeout(milliseconds, callback) {
    new Timer(new Duration(milliseconds: milliseconds), () {
      if (callback != null) {
        callback();
      }
    });
  }

  static Future delayed(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }
}
