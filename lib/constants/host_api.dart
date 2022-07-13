const IP = "192.168.0.102";
const version = "v1";
final host = "http://$IP:8080";
final minioHost = "http://$IP:9000/media";

final mediaUrl = host + "/api/$version/media";
final userUrl = host + "/api/$version/user";
final followUrl = host + "/api/$version/follow-relation";
final followRequestUrl = host + "/api/$version/follow-request";
final mailUrl = host + "/api/$version/mail";
final authenticateUrl = host + "/api/$version/authenticate";

// messenger service
final conversationUrl = host + "/api/$version/conversation";
