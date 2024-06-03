import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: "")
abstract class NetworkService {
  factory NetworkService(Dio dio, {String? baseUrl}) = _NetworkService;

  @POST('signUpUrl')
  Future<dynamic> signUp(@Body() FormData data);

}
