import 'package:flutter_application/repository/authentication_repository/api/api_error.dart';

class ApiResponse {
  // _data will hold any response converted into 
  // its own object. For example user.
  Object? data; 
  // _apiError will hold the error object
  ApiError? apiError;
}