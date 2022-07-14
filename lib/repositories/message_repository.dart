import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/repositories/api_repository.dart';

class MessageRepository {
  final ApiRepository apiRepository = ApiRepository();
  static MessageRepository _messageRepository = MessageRepository._();

  MessageRepository._();

  static MessageRepository getInstance() {
    return _messageRepository;
  }

  Future<List<Message>> getMessage(
      {required int conversationId,
      required int page,
      required int limit}) async {
    ApiModel model = ApiModel(
        url: messageUrl,
        params: {
          "conversationId": "$conversationId",
          "page": "$page",
          "limit": "$limit"
        },
        parse: (data) {
          return data.map<Message>((json) => Message.fromJson(json)).toList();
        });
    List<Message> messages = await apiRepository.get(model);
    return messages;
  }
}
