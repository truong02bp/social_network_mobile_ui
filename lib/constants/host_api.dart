
const IP = "178.128.49.123";
const version = "v1";
final host = "http://$IP:8080";
final minioHost = "http://$IP:60001/media";

final mediaUrl = host + "/api/$version/media";
final userUrl = host + "/api/$version/user";
final mailUrl = host + "/api/$version/mail";