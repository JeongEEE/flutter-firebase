import 'package:flutter/material.dart';
import 'package:instagram_clone/store/global_data.dart' as global;
import 'package:instagram_clone/utils/screen.dart';

showAppModal({
  title = '',
  content = '',
  confirmBtnText = '확인',
  cancelBtnText = '취소',
  onConfirm,
  onCancel,
  headerContent,
  contentWidget,
  bottomWidget,
  resetContent,
}) {
  if (onCancel == null) {
    onCancel = () {
      Navigator.of(global.appContext).pop();
    };
  }
  showDialog(
    context: global.appContext,
    // barrierColor: Colors.black45,
    barrierDismissible: true,
    builder: (context) {
      const Color borderColor = Color(0xffDBDBDB);
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              resetContent != null
                  ? resetContent
                  : Container(
                      width: AppScreen.getWidth() - 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          headerContent != null
                              ? headerContent
                              : Container(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.only(top: 30),
                            child: contentWidget != null
                                ? contentWidget
                                : Text(
                                    content,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xff949494)),
                                  ),
                          ),
                          Container(
                            height: 48,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1, color: borderColor),
                              ),
                            ),
                            child: bottomWidget != null
                                ? bottomWidget
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: onCancel,
                                        child: Container(
                                          child: Text(
                                            cancelBtnText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1, color: borderColor),
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          if (onConfirm != null) {
                                            Navigator.of(global.appContext).pop();
                                            onConfirm();
                                          } else {
                                            Navigator.of(global.appContext).pop();
                                          }
                                        },
                                        child: Container(
                                          child: Text(
                                            confirmBtnText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
