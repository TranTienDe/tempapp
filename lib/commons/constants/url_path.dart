class UrlPath {
  static const String host = "http://103.68.251.104:8080";
  static const String api = "/api";
  static const String token = "/token";

    // login
  static const String login = api + "/Login";
  static const String getUserLogin = login + "/GetUserLogin";

  // Sign up
  static const String signUp = api + "/SignUp";
  static const String checkUserName = signUp + "/CheckUserName";
  static const String signUpAccount = signUp + "/SignUpAccount";

}