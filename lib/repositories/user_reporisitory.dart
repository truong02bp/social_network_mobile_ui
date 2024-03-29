import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';
import 'package:social_network_mobile_ui/models/dto/authentication_request.dart';
import 'package:social_network_mobile_ui/models/dto/media_dto.dart';
import 'package:social_network_mobile_ui/models/dto/profile_dto.dart';
import 'package:social_network_mobile_ui/models/dto/user_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/api_repository.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository();
  final ApiRepository apiRepository = new ApiRepository();

  static getInstance() {
    return _instance;
  }

  Future<String?> login(
      {required String email, required String password}) async {
    ApiModel model = ApiModel(
        url: authenticateUrl,
        body: AuthenticationRequest(email: email, password: password));
    model.isLogin = true;
    String token = await apiRepository.post(model);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    return token;
  }

  Future<User?> getUserLogin() async {
    ApiModel model = ApiModel(
        url: userUrl,
        parse: (json) {
          return User.fromJson(json);
        });
    User? user = await apiRepository.get(model);
    return user;
  }

  Future<User?> updateAvatar({required MediaDto mediaDto}) async {
    ApiModel model = ApiModel(
        url: userUrl + "/avatar",
        body: mediaDto,
        parse: (json) {
          return User.fromJson(json);
        });
    User? user = await apiRepository.put(model);
    return user;
  }

  Future<String?> update({required User user}) async {
    ApiModel model = ApiModel(
      url: userUrl,
      body: user,
    );
    String message = await apiRepository.put(model);
    return message;
  }

  Future<User?> updatePassword({required UserDto userDto}) async {
    ApiModel model = ApiModel(
        url: userUrl + "/password",
        body: userDto,
        parse: (json) {
          return User.fromJson(json);
        });
    User? user = await apiRepository.put(model);
    return user;
  }

  Future<ProfileDto?> getProfileInformation({userId}) async {
    ApiModel model = ApiModel(
        url: userUrl + "/profile",
        params: {"userId": "$userId"},
        parse: (json) {
          return ProfileDto.fromJson(json);
        });
    ProfileDto? profile = await apiRepository.get(model);
    return profile;
  }

  Future<String?> sendOtp({required String email, required String name}) async {
    String url = mailUrl + "/otp";
    ApiModel apiModel =
        new ApiModel(url: url, params: {"name": name, "email": email});
    String? otp = await apiRepository.post(apiModel);
    return otp;
  }
}
