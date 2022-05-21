import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';
import 'package:social_network_mobile_ui/repositories/api_repository.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository();
  final ApiRepository apiRepository = new ApiRepository();

  static getInstance() {
    return _instance;
  }

  Future<String?> sendOtp({required String email, required String name}) async {
    String url = mailUrl + "/otp";
    ApiModel apiModel =
        new ApiModel(url: url, params: {"name": name, "email": email});
    String? otp = await apiRepository.post(apiModel);
    return otp;
  }
}
