import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class counterScreenController extends GetxController {
  RxBool isSoundOn = true.obs;

  RxBool isStarted = false.obs;
  RxBool isCompleted = false.obs;
  final audioPlayer = AudioPlayer();


  @override
  void onInit() {
    setAudio();
    super.onInit();
  }

  Future setAudio() async{
    audioPlayer.setAudioSource(AudioSource.asset("assets/beep.mp3"));
    await audioPlayer.setLoopMode(LoopMode.all);
  }

}
