import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/repositories/api_repository.dart';

class ConversationRepository {

  final ApiRepository apiRepository = ApiRepository();
  static ConversationRepository conversationRepository =
  ConversationRepository._();

  ConversationRepository._();

  static ConversationRepository getInstance() {
    return conversationRepository;
  }

  Future<List<Conversation>> getConversation(
      {required int userId, required int page, required int limit}) async {
    ApiModel model = ApiModel(
        url: conversationUrl,
        params: {"userId": "$userId", "page": "$page", "limit": "$limit"},
        parse: (data) {
          return data.map<Conversation>((json) => Conversation.fromJson(json))
              .toList();
        }
    );
    List<Conversation> conversations = await apiRepository.get(model);
    return conversations;
  }

}
