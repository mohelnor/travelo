import 'package:get/get.dart';
import 'const.dart';

class UserProvider extends GetConnect {
  Future<Response> authUser(Map data) => post('${myUrl}query/', data);
  Future<Response> addUser(Map data) => post('${myUrl}insert/', data);
}
