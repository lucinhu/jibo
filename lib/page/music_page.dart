import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<Widget> musicButtons = [];
  List<String> texts = [
    "只因",
    "你",
    "太",
    "美",
    "唱",
    "跳",
    "rap",
    "篮球",
    "music",
    "坤坤",
    "练习坤",
    "两年半",
    "大家好",
    "全民制作人们",
    "我是",
    "喜欢",
    "你干嘛~",
    "哈嗨",
    "嗨哟",
    "你好烦",
    "鸡你太美",
    "你干嘛哎呦",
    "啊哈嗨mua",
    "开团の神曲",
    "开团の神曲1",
    "开团の神曲2",
    "听我说谢谢只因",
    "鸡你太美曲",
    "仙剑奇侠只因",
    "春只因序曲",
    "营销只因の宏大叙事bgm",
    "只因のdisco",
    "只因の打鸣",
    "只因南",
    "营销只因のbgm",
    "只因の吟唱"
  ];
  List<AudioPlayer> audioPlayers = [];

  @override
  void initState() {
    for (var i = 1; i <= texts.length; i++) {
      if (i < 24) {
        audioPlayers.add(AudioPlayer());
      } else {
        audioPlayers.add(AudioPlayer(playerId: "music$i"));
      }

      musicButtons.add(ElevatedButton(
          onPressed: (() {
            if (i < 24) {
              audioPlayers[i - 1] = AudioPlayer();
              audioPlayers[i - 1].play(AssetSource('music/m$i.mp3'));
            } else {
              if (audioPlayers[i - 1].state == PlayerState.playing) {
                audioPlayers[i - 1].stop();
              } else {
                audioPlayers[i - 1].play(AssetSource('music/m$i.mp3'));
              }
            }
          }),
          child: Text(texts[i - 1])));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [Wrap(spacing: 5, children: musicButtons)],
      ),
    );
  }
}
