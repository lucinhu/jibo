import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 5,
        children: [
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m1.mp3'));
              }),
              child: const Text("鸡")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m2.mp3'));
              }),
              child: const Text("你")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m3.mp3'));
              }),
              child: const Text("太")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m4.mp3'));
              }),
              child: const Text("美")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m5.mp3'));
              }),
              child: const Text("唱")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m6.mp3'));
              }),
              child: const Text("跳")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m7.mp3'));
              }),
              child: const Text("rap")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m8.mp3'));
              }),
              child: const Text("篮球")),
          ElevatedButton(
              onPressed: (() {
                AudioPlayer().play(AssetSource('music/m9.mp3'));
              }),
              child: const Text("music")),
        ],
      ),
    );
  }
}
