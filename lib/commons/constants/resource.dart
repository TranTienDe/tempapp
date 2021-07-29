class Resource {
  static const bool debug = true;
  static const String appName = 'iCarevn';
  static const String success = 'Success';
  static const String str_login = 'Đăng nhập';
  static const String str_register = 'Đăng ký tài khoản';
  static const String str_call_support = 'Gọi điện thoại hỗ trợ';
  static const String str_forgot_password = 'Quên mật khẩu';
  static const String str_forgot_password_title =
      'Vui lòng liên hệ với chúng tôi để nhận lại mật khẩu.';
  static const String str_otp_code = 'Nhận mã OTP';

  static const int temperature_limit = 37;
  static const int battery_limit = 20;

  static const String phone_number = "0945 365 012";
  static const String slow_spring_board = "slow_spring_board.mp3";
  static const String alarm_Audio_Path = 'sounds/${Resource.slow_spring_board}';

  static const String bluetooth_device_name = "thermometer";

  //Thermometer nhiệt dô
  static const String UUID_TEMPERATURE_SERVICE = "00001809-0000-1000-8000-00805f9b34fb";
  static const String UUID_TEMPERATURE_CHARACTERISTIC = "00002a1e-0000-1000-8000-00805f9b34fb";

}
