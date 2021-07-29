import 'package:tempapp/commons/utils/text_input_formatter.dart';

final amountValidator =
    RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

final numberValidator = RegExInputFormatter.withRegex(r'(^[0-9]*$)');

String validateName(String value) {
  //String pattern = r'(^[a-zA-Z ]*$)';
  //RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Name is Required";
  }
  /*else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }*/
  return '';
}

String validateMobile(String value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Chưa nhập số điện thoại.";
  } else if (value.length < 10) {
    return "Số điện thoại từ 10 kí tự.";
  } else if (!regExp.hasMatch(value)) {
    return "Số điện thoại yêu cầu là chữ số.";
  }
  return '';
}

String validatePass(String pass) {
  if (pass.length == 0) {
    return "Chưa nhập mật khẩu";
  }

  if (pass.length < 6) {
    return "Mật khẩu phải từ 6 kí tự trở lên!";
  }
  return '';
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return '';
  }
}
