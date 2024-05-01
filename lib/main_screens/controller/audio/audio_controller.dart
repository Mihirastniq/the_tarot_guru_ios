// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class AudioController {
//   late SharedPreferences sharedPreferences;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   final List<String> oshoAudioList = [
//     '01_GARDEN OF THE BELOVED 5.22 OSHO ZEN TAROT (MUSIC FOR TAROT READING).mp3',
//     '02_OM_Music.mp3'
//   ];
//
//   final List<String> riderWaiteAudioList = [
//
//   ];
//
//   String? selectedAudio;
//
//   Future<void> initSharedPreferences() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     selectedAudio = sharedPreferences.getString('selectedAudio');
//     // Don't automatically play music here
//   }
//
//   Future<void> playAudio(String audioPath) async {
//     String fullPath = 'https://thetarotguru.com/tarotapi/music/osho/$audioPath';
//     await _audioPlayer.play(UrlSource(fullPath));
//   }
//
//   Future<void> stopAudio() async {
//     await _audioPlayer.stop();
//   }
//
//   Future<void> saveSelectedAudio(String audioPath) async {
//     await sharedPreferences.setString('selectedAudio', audioPath);
//     selectedAudio = audioPath;
//   }
//
//   Future<void> playSelectedAudio() async {
//     if (selectedAudio == null) {
//       selectedAudio = oshoAudioList.first;
//       await saveSelectedAudio(selectedAudio!);
//     }
//     await playAudio(selectedAudio!);
//   }
//
//   Future<void> muteAudio() async {
//     await _audioPlayer.setVolume(0);
//   }
//
//   Future<void> unMuteAudio() async {
//     await _audioPlayer.setVolume(1);
//   }
//
//   Future<void> toggleAudio() async {
//     if(_audioPlayer.volume == 1) {
//       await muteAudio();
//     } else {
//       await unMuteAudio();
//     }
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController {
  late SharedPreferences sharedPreferences;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 1;

  final List<String> oshoAudioList = [
    '01_GARDEN OF THE BELOVED 5.22 OSHO ZEN TAROT (MUSIC FOR TAROT READING).mp3',
    '02_OM_Music.mp3'
  ];

  String? selectedAudio;
int currentAudio = 1;

  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    selectedAudio = '01_GARDEN OF THE BELOVED 5.22 OSHO ZEN TAROT (MUSIC FOR TAROT READING).mp3';
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

  Future<void> muteAudio() async {
    // Mute audio by setting volume to 0
    await _audioPlayer.setVolume(0);
  }

  Future<void> unMuteAudio() async {
    await _audioPlayer.setVolume(1);
  }

  Future<void> toggleAudio() async {
    switch(currentAudio){
      case 1:
        unMuteAudio();
        await playAudio(oshoAudioList[1]);
        currentAudio = 2;
        break;
      case 2:
        muteAudio();
        currentAudio = 3;
        break;
      case 3:
        unMuteAudio();
        await playAudio(oshoAudioList[0]);
        currentAudio = 1;
        break;
      default:
        muteAudio();
            currentAudio = 1;
            break;

    }

  }

}
