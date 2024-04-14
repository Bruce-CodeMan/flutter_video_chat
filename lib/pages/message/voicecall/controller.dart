import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_video_chat/common/store/store.dart';
import 'package:flutter_video_chat/common/values/values.dart';
import 'package:flutter_video_chat/pages/message/voicecall/state.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final VoiceCallState state = VoiceCallState();
  final player = AudioPlayer();
  final db = FirebaseFirestore.instance;
  final id = UserStore.to.profile.id;
  String aId = appId;
  late final RtcEngine engine;

  // 两人聊天
  ChannelProfileType channelProfileType = ChannelProfileType.channelProfileCommunication;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    state.toName.value = data["toName"] ?? "";
    state.toToken.value = data["toToken"] ?? "";
    state.toAvatar.value = data["toAvatar"] ?? "";
    initEngine();
  }

  Future<void> initEngine() async {
    player.setAsset(Asset.soundMp3Path);
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: aId
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        state.isJoined.value = true;
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) async{
        print('[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid, elapsed: $elapsed');
        await player.pause();
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('--user leave the room');
        print('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        state.isJoined.value = false;
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) {
        print('--time');
        print(stats.duration);
      }
    ));

    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming
    );

    await joinChannel();
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    await engine.joinChannel(
      token: "007eJxTYIi5zWsvwMd9fta5JZ0b2h6tEGUMm9c9h/mY84dMqzVBF3IUGEySLAzTEs2NEg2MzE1SzE2SEtNMjIwMLS0t0oxNLc1T5S5LpzUEMjKsa93IxMgAgSA+J0NJanFJfHJGYgkDAwCOHyBO", 
      channelId: "test_chat", 
      uid: 0, 
      options: ChannelMediaOptions(
        channelProfile: channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster
      )
    );
    EasyLoading.dismiss();
  }

  void leaveChannel() async{
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  @override
  void onClose() {
    super.onClose();
    _dispose();
  }


  Future<void> _dispose() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }
}

