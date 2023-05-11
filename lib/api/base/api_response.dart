// @dart=2.9
import 'package:get/get_connect/http/src/response/response.dart';

class ApiResponse {
  final Response response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
