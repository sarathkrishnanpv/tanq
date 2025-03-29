import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';

class Constants {
  static double width = 0;
  static double height = 0;
}

void toastmsg(String msg) {
  Fluttertoast.showToast(
    fontSize: 12,
    msg: msg,
    backgroundColor: AppColors.green,
    textColor: AppColors.backgroundColor,
  );
}

void toastmsgTop(String msg) {
  Fluttertoast.showToast(
    gravity: ToastGravity.CENTER,
    fontSize: 12,
    msg: msg,
    backgroundColor: AppColors.green,
    textColor: AppColors.backgroundColor,
  );
}

void errormsg(String msg) {
  Fluttertoast.showToast(
      fontSize: 14,
      msg: msg,
      backgroundColor: AppColors.red,
      textColor: AppColors.backgroundColor);
}

void customesnack(String msg) {
  Fluttertoast.showToast(
      fontSize: 14,
      msg: msg,
      backgroundColor: AppColors.red,
      textColor: AppColors.backgroundColor);
}
