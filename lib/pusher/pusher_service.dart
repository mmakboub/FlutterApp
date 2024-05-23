import 'package:flutter/foundation.dart';
import 'package:library_app/pusher/pusher_keys.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherSevices {
  static final PusherSevices instance = PusherSevices._internal();
  PusherSevices._internal();
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  // final PusherAuthRepo pusherAuthRepo = PusherAuthRepo();

  // void initilizePusher(context, String? token) async {
  //   try {
  //     authToken = token;
  //     await pusher.init(
  //         apiKey: PusherKeys.pusherKey,
  //         cluster: PusherKeys.pusherCluster,
  //         onAuthorizer: onAuthorizer);
  //     onPrivatePostChannel(context);
  //     onPrivateCommentChannel(context);
  //   } catch (e, s) {
  //     debugPrint(e.toString());
  //     debugPrint(s.toString());
  //   }
  // }

  // dynamic onAuthorizer(
  //     String channelName, String socketId, dynamic options) async {
  //   final Map? pusherAuthResponse = await pusherAuthRepo.authorize(
  //       token: authToken, channelName: channelName, socketId: socketId);
  //   if (pusherAuthResponse != null) {
  //     return pusherAuthResponse;
  //   }
  // }
}
