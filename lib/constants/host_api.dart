const IP = "192.168.0.104";
const version = "v1";
final port = 8080;
final host = "http://$IP:$port";
final minioHost = "http://$IP:9000/media";

final mediaUrl = host + "/api/$version/media";
final userUrl = host + "/api/$version/user";
final followUrl = host + "/api/$version/follow-relation";
final followRequestUrl = host + "/api/$version/follow-request";
final mailUrl = host + "/api/$version/mail";
final authenticateUrl = host + "/api/$version/authenticate";

// messenger service
final conversationUrl = host + "/api/$version/conversation";
final messageUrl = host + "/api/$version/message";
final messageMediaUrl = host + "/api/$version/message/media";
