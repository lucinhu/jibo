import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:jibo/api/github_api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'page/music_page.dart';
import 'page/picture_page.dart';
import 'page/text_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int navigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("只因宝盒"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem(
                  value: '检查更新',
                  child: Text('检查更新'),
                )
              ];
            },
            onSelected: (value) async {
              if (value == '检查更新') {
                var packageInfo = await PackageInfo.fromPlatform();
                var data = await GithubApi.requestLatestRelease();
                var latestVersion = data.name?.replaceFirst(RegExp(r'v'), '');
                var currentVersion = packageInfo.version;
                if (latestVersion == currentVersion) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("已是最新版")));
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("有新版本:$latestVersion"),
                            TextButton(
                              child: const Text("跳转下载"),
                              onPressed: () async {
                                String dowloadBase =
                                    "https://github.com/lucinhu/jibo/releases/download";
                                //TODO 自动选择合适系统/abi的版本下载
                                if (Platform.isAndroid) {
                                  //安卓
                                  var supportedAbis =
                                      (await DeviceInfoPlugin().androidInfo)
                                          .supportedAbis;
                                  for (var i in supportedAbis) {
                                    log(i);
                                  }

                                  if (supportedAbis.contains("x86_64")) {
                                    //跳转下载x86_64版本
                                    launchUrlString(
                                        "$dowloadBase/v$latestVersion/app-x86_64-release.apk",
                                        mode: LaunchMode.externalApplication);
                                  } else if (supportedAbis
                                      .contains("arm64-v8a")) {
                                    //跳转下载arm64-v8a版本
                                    launchUrlString(
                                        "$dowloadBase/v$latestVersion/app-arm64-v8a-release.apk",
                                        mode: LaunchMode.externalApplication);
                                  } else if (supportedAbis
                                      .contains("armeabi-v7a")) {
                                    //跳转下载armeabi-v7a版本
                                    launchUrlString(
                                        "$dowloadBase/v$latestVersion/app-armeabi-v7a-release.apk",
                                        mode: LaunchMode.externalApplication);
                                  }
                                } else if (Platform.isLinux) {
                                  //linux
                                  launchUrlString(
                                      "$dowloadBase/v$latestVersion/Jibo-release-linux-x64-x86_64.AppImage",
                                      mode: LaunchMode.externalApplication);
                                } else if (Platform.isIOS) {
                                  //TODO ios
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationBarIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Image(
                image:
                    AssetImage("assets/image/navigation_bar/cock_crow32.png"),
              ),
              label: "坤鸣"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage("assets/image/navigation_bar/ctrl.png"),
              ),
              label: "坤图"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage("assets/image/navigation_bar/feet.png"),
              ),
              label: "坤文")
        ],
        onTap: ((index) {
          setState(() {
            navigationBarIndex = index;
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          });
        }),
      ),
      body: PageView(
        controller: pageController,
        children: const [MusicPage(), PicturePage(), TextPage()],
        onPageChanged: (index) {
          setState(() {
            navigationBarIndex = index;
          });
        },
      ),
    );
  }
}
