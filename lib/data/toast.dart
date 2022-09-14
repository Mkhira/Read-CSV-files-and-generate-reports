import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static void customToast({required String customMsg, required Color backgroundColor}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: customMsg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 17.sp,
    );
  }
}
