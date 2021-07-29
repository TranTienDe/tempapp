import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/constants/url_path.dart';
import 'package:tempapp/models/user_model.dart';
import 'package:tempapp/services/base_service.dart';

class LoginService {
  Future<UserModel> getUserLogin({required String json}) async {
    return await BaseService.instance.post(UrlPath.getUserLogin, body: json).then((json) {
      String message = json["Message"];
      if (message != Resource.success) throw message;
      return UserModel.fromJson(json["Data"]);
    });
  }
}