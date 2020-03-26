import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/timer.dart';
import 'package:instagram_clone/store/global_data.dart' as global;

bool isShowingDialog = false;
bool isShowingAppModal = false;

/*
 * 
 * toast 
*/
showToast(String text, {duration = 1000, Function next}) async {
  OverlayState overlayState = Overlay.of(global.appContext);
  OverlayEntry overlayEntry = new AppOverlay().build(new Container(
    padding: new EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: new BoxDecoration(
      color: Colors.black54,
      borderRadius: new BorderRadius.circular(4),
    ),
    child: new Text(
      text,
      style: new TextStyle(color: Colors.white),
    ),
  ));
  overlayState?.insert(overlayEntry);
  await AppTimer.delayed(duration);
  overlayEntry?.remove();
  if (next != null) {
    next();
  }
}

/*
 * 
 * loading 
*/
OverlayEntry overlayEntryOfLoading;
showLoading({text = ''}) {
  hideLoading();
  OverlayState overlayState = Overlay.of(global.appContext);
  overlayEntryOfLoading = new AppOverlay().build(Column(
    children: <Widget>[
      Expanded(
        child: Container(),
      ),
      new Container(
        padding: new EdgeInsets.all(20),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(
            new Radius.circular(8),
          ),
          color: Colors.black54,
        ),
        child: Column(
          children: <Widget>[
            CupertinoActivityIndicator(),
            Container(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    height: text == '' ? 0 : 1),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(),
      ),
    ],
  ));
  overlayState?.insert(overlayEntryOfLoading);
}

hideLoading() {
  overlayEntryOfLoading?.remove();
  overlayEntryOfLoading = null;
  global.canIBack = true;
}

class AppOverlay {
  build(child, {mask: true}) {
    return OverlayEntry(builder: (BuildContext context) {
      return mask
          ? Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: child,
                ),
              ),
            )
          : child;
    });
  }
}