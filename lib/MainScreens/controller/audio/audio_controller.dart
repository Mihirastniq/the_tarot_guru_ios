import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  late SharedPreferences sharedPreferences;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<String> oshoAudioList = [
    '01_GARDEN OF THE BELOVED 5.22 OSHO ZEN TAROT (MUSIC FOR TAROT READING).mp3',
  ];

  final List<String> riderWaiteAudioList = [
    // Your list of Rider Waite audio files...
  ];

  String? selectedAudio;

  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    selectedAudio = sharedPreferences.getString('selectedAudio');
    // Don't automatically play music here
  }

  Future<void> playAudio(String audioPath) async {
    String fullPath = 'https://thetarotguru.com/tarotapi/music/osho/$audioPath';
    await _audioPlayer.play(UrlSource(fullPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> saveSelectedAudio(String audioPath) async {
    await sharedPreferences.setString('selectedAudio', audioPath);
    selectedAudio = audioPath;
  }

  Future<void> playSelectedAudio() async {
    if (selectedAudio == null) {
      selectedAudio = oshoAudioList.first;
      await saveSelectedAudio(selectedAudio!);
    }
    await playAudio(selectedAudio!);
  }

  void selectAudio(String audioPath) async {
    await saveSelectedAudio(audioPath);
    await playSelectedAudio();
  }

  Future<void> muteAudio() async {
    // Mute audio by setting volume to 0
    await _audioPlayer.setVolume(0);
  }

  Future<void> unMuteAudio() async {
    await _audioPlayer.setVolume(1);
  }

  Future<void> toggleAudio() async {
    if(_audioPlayer.volume == 1) {
      await muteAudio();
    } else {
      await unMuteAudio();
    }
  }

  Widget buildAudioOptionsList(String tarotType) {
    List<String> audioList = [];
    if (tarotType == 'Osho Zen') {
      audioList = oshoAudioList;
    } else if (tarotType == 'Rider Waite') {
      audioList = riderWaiteAudioList;
    }

    return Container(
      height: 400,
      width: double.maxFinite, // Ensure the content occupies the full width
      child: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: (context, index) {
          String audio = audioList[index];
          return ListTile(
            title: Text(audio),
            onTap: () {
              selectAudio(audio);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
