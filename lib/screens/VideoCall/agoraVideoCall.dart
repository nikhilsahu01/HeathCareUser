import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../core/coreServices/socket_service/join_call_provider.dart';
import '../../core/utils/global_variables.dart';



class AgoraVideoCallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final String appointmentId;
  final int uid;

  const AgoraVideoCallScreen({
    Key? key,
    required this.channelName,
    required this.token,
    required this.appointmentId,
    required this.uid,
  }) : super(key: key);

  @override
  State<AgoraVideoCallScreen> createState() => _AgoraVideoCallScreenState();
}

class _AgoraVideoCallScreenState extends State<AgoraVideoCallScreen> {
  late RtcEngine _engine;
  bool _localUserJoined = false;
  // int? _remoteUid;
  final List<int> _remoteUids = [];
  bool _muted = false;
  bool _cameraSwitched = false;
  bool _hasEndedCall = false;

  static const String appId = 'a564b76eeb0c4f8cbd1216e06d446ffc';

  @override
  void initState() {
    super.initState();
    _initAgora();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<JoinCallNotifier>().addListener(_checkCanJoinStatus);
  }

  void _checkCanJoinStatus() {
    final notifier = context.read<JoinCallNotifier>();
    if (!notifier.canJoin(widget.appointmentId)) {
      debugPrint("⚠️ canJoin is now FALSE for ${widget.appointmentId} — ending call");
      _endCallAndExit();
    }
  }

  Future<void> _endCallAndExit() async {
    if (_hasEndedCall) return; // prevent multiple pops
    _hasEndedCall = true;
    await _engine.leaveChannel();
    if (mounted) Navigator.pop(context);
  }
  Future<void> _initAgora() async {
    await [Permission.camera, Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Local user joined: ${connection.localUid}');
          setState(() => _localUserJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            if (!_remoteUids.contains(remoteUid)) {
              _remoteUids.add(remoteUid);
            }
          });
        },

        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUids.remove(remoteUid);
          });
        },
        // onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        //   debugPrint('Remote user joined: $remoteUid');
        //   setState(() => _remoteUid = remoteUid);
        // },
        // onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        //   debugPrint('Remote user left: $remoteUid');
        //   setState(() => _remoteUid = null);
        // },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('Agora error: $err - $msg');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Agora error: $msg')),
          );
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          debugPrint('Left channel: ${connection.channelId}');
        },
      ),
    );

    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: widget.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  @override
  void dispose() {
    context.read<JoinCallNotifier>().removeListener(_checkCanJoinStatus);
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }
  Widget _buildVideos() {
    int totalUsers = _remoteUids.length + 1;

    /// 🟡 ONLY YOU
    if (totalUsers == 1) {
      return const Center(
        child: Text(
          "Waiting for others...",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    /// 🟢 2 USERS → FULL SCREEN REMOTE
    if (totalUsers == 2) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUids.first),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    }

    /// 🔵 3 USERS → HALF + HALF
    return Column(
      children: [
        Expanded(
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: _remoteUids[0]),
              connection: RtcConnection(channelId: widget.channelName),
            ),
          ),
        ),
        Expanded(
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: _remoteUids[1]),
              connection: RtcConnection(channelId: widget.channelName),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _remoteVideo() {
  //   if (_remoteUid != null) {
  //     return AgoraVideoView(
  //       controller: VideoViewController.remote(
  //         rtcEngine: _engine,
  //         canvas: VideoCanvas(uid: _remoteUid),
  //         connection: RtcConnection(channelId: widget.channelName),
  //       ),
  //     );
  //   } else {
  //     return const Center(
  //       child: Text(
  //         'Waiting for other user to join...',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     );
  //   }
  // }

  // Widget _localVideo() {
  //   return _localUserJoined
  //       ? AgoraVideoView(
  //     controller: VideoViewController(
  //       rtcEngine: _engine,
  //       canvas: const VideoCanvas(uid: 0),
  //     ),
  //   )
  //       : const Center(child: ThreeDotsLoader(color: ColorResource.primaryBlue,));
  // }
  Widget _localVideo() {
    if (!_localUserJoined) {
      return const Center(
        child: ThreeDotsLoader(color: ColorResource.primaryBlue),
      );
    }

    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mute button
          RawMaterialButton(
            onPressed: () {
              setState(() => _muted = !_muted);
              _engine.muteLocalAudioStream(_muted);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _muted ? Colors.white : Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.red : Colors.white,
              size: 20.0,
            ),
          ),
          // End call button
          RawMaterialButton(
            onPressed: () async {
              await _engine.leaveChannel();
              if (mounted) Navigator.pop(context);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          // Switch camera button
          RawMaterialButton(
            onPressed: () {
              setState(() => _cameraSwitched = !_cameraSwitched);
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: ColorResource.primaryBlue,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildVideos(),
          // Center(child: _remoteVideo()),
          Positioned(
            top: 40,
            left: 16,
            width: 100,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _localVideo(),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }
}
