import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/login_with_email_password_failure.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/signup_with_email_password_failure.dart';
import 'package:flutter_application/repository/user_repository/user_repository.dart';
import 'package:flutter_application/storage/secure_storage.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class AutheticationRepository extends GetxController {
  static AutheticationRepository get instance => Get.find();

  UserRepository userRepository = Get.put(UserRepository());

  // ! FirebaseAuth only works with Flutter only approach atm
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = _auth.currentUser.obs;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/signupScreen');
    } else {
      Get.offAllNamed('/');
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password, SignupData signupData) async {
    // Flutter only approach
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create user entry in Firestore
      userRepository
          .createUser(userRepository.createUserFromSignupData(signupData));

      // save the firebase user jwt token in local storage
      SecureStorage.setJwt(await firebaseUser.value!.getIdToken(true));

      firebaseUser.value != null
          ? Get.offAllNamed('/')
          : Get.offAllNamed('/signupScreen');
    } on FirebaseAuthException catch (e) {
      final exception = SignupWithEmailPasswordFailure.code(e.code);
      return exception.message;
    } catch (e) {
      final exception = SignupWithEmailPasswordFailure();
      return exception.message;
    }

    // Flutter + Golang approach
    // ApiResponse apiResponse = ApiResponse();
    // try {
    //   final response = await http
    //       .post(Uri.http(ApiConstants.baseUrl, ApiConstants.signUpUrl),
    //           body: jsonEncode({
    //             "email": email,
    //             "password": password,
    //           }),
    //           headers: {
    //         'Content-Type': 'application/json',
    //         'Accept': 'application/json',
    //       });

    //   switch (response.statusCode) {
    //     case 200:
    //       apiResponse.data = response.body;
    //       break;
    //     case 202:
    //       apiResponse.data = response.body;
    //       break;
    //     case 401:
    //       apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
    //       break;
    //     default:
    //       apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
    //       break;
    //   }
    // } on SocketException catch (e) {
    //   apiResponse.apiError = ApiError(error: e.message);
    // }

    // if api response contains data, most likely no error occured
    // save the JWT token returned from http GET to local storage
    // if (apiResponse.data != null) {
    //   saveJwtToStorage(apiResponse.data.toString());
    // }

    // if api response contains error, most likely error occured
    // if (apiResponse.data == null && apiResponse.apiError != null) {
    //   final exception =
    //       SignupWithEmailPasswordFailure.code(apiResponse.apiError!.error);
    //   return exception.message;
    // }

    return null;
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final exception = LoginWithEmailPasswordFailure.code(e.code);
      // Get.snackbar('Error signing in -', exception.message);
      return exception.message;
    } catch (_) {
      final exception = LoginWithEmailPasswordFailure();
      // Get.snackbar('Error signing in - ', exception.message);
      return exception.message;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
