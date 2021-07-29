import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/constants/url_path.dart';
import 'package:tempapp/services/base_service.dart';

class RegisterService {
  RegisterService._privateConstructor();

  static final RegisterService instanse = RegisterService._privateConstructor();

  //Kiểm tra số điện thoại đã tồn tại
  Future<int> checkExistPhone(String json) async {
    return await BaseService.instance.post(UrlPath.checkUserName, body: json).then((json) {
      String message = json['Message'];
      if (message != Resource.success) throw message;
      return int.parse(json['Data'].toString());
    });
  }

  // Tạo thông tin của tài khoản.
  Future<int> signUpAccount(String json) async {
    return await BaseService.instance.post(UrlPath.signUpAccount, body: json).then((json) {
      String message = json['Message'];
      if (message != Resource.success) throw message;
      return int.parse(json['Data'].toString());
    });
  }
}
