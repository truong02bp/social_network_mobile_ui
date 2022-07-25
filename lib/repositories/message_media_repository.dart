import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';
import 'package:social_network_mobile_ui/models/dto/media_dto.dart';
import 'package:social_network_mobile_ui/models/message_media.dart';
import 'package:social_network_mobile_ui/repositories/api_repository.dart';

class MessageMediaRepository {
  final ApiRepository apiRepository = ApiRepository();
  static MessageMediaRepository _messageMediaRepository =
      MessageMediaRepository._();

  MessageMediaRepository._();

  static MessageMediaRepository getInstance() {
    return _messageMediaRepository;
  }

  Future<MessageMedia> create({required MediaDto dto}) async {
    String url = messageMediaUrl;
    ApiModel apiModel = new ApiModel(
      url: url,
      body: dto,
      parse: (json) => MessageMedia.fromJson(json),
    );
    MessageMedia media = await apiRepository.post(apiModel);
    return media;
  }

  Future<List<MessageMedia>> createAll({required List<MediaDto> dtos}) async {
    String url = messageMediaUrl;
    ApiModel apiModel = new ApiModel(
        url: url + "/all",
        body: dtos,
        parse: (data) {
          return data
              .map<MessageMedia>((json) => MessageMedia.fromJson(json))
              .toList();
        });
    List<MessageMedia> medias = await apiRepository.post(apiModel);
    return medias;
  }
}
