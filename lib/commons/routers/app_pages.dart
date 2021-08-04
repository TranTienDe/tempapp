import 'package:get/get.dart';
import 'package:tempapp/pages/dashboard/dashboard_binding.dart';
import 'package:tempapp/pages/dashboard/dashboard_page.dart';
import 'package:tempapp/pages/dashboard/home/widgets/charts/chart_page.dart';
import 'package:tempapp/pages/login/forgot_password_page.dart';
import 'package:tempapp/pages/login/login_binding.dart';
import 'package:tempapp/pages/login/login_page.dart';
import 'package:tempapp/pages/register/register_binding.dart';
import 'package:tempapp/pages/register/register_page.dart';
import 'package:tempapp/pages/splash/splash_binding.dart';
import 'package:tempapp/pages/splash/splash_page.dart';

class Paths {
  static const Splash = 'Splash';
  static const Login = '/Login';
  static const ForgotPassword = '/ForgotPassword';
  static const Register = '/Register';

  //Dashboard
  static const Dashboard = '/';
}

class AppPages {
  static final routers = [
    GetPage(
        name: Paths.Splash, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(
        name: Paths.Login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Paths.ForgotPassword, page: () => ForgotPasswordPage()),
    GetPage(
        name: Paths.Register,
        page: () => RegisterPage(),
        binding: RegisterBinding()),

    //Dashboard
    GetPage(
        name: Paths.Dashboard,
        page: () => DashboardPage(),
        binding: DashboardBinding()),
  ];
}
