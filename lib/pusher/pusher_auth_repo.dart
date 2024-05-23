class PusherAuthRepo {
  // HttpAPIManager httpAPIManager = HttpAPIManager();
  Future<Map> authorize(
      {required String authToken,
      required String socketId,
      required String channelName}) async {
    final headers = {
      "access_token": 'Bearer $authToken',
      "Content-Type": "HeaderContentType-pusher",
      "socket_id": "socketId",
      'channel name': "channelName"
    };
    return headers;
  }
}
