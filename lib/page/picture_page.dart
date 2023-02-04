import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({super.key});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //创建头像区图片项
    List<Widget> jis = [];
    for (int i = 0; i < 53; i++) {
      jis.add(JisItem("assets/image/ji/ji$i.jpg"));
    }
    List<Widget> kunGifs = [];
    for (int i = 0; i < 19; i++) {
      kunGifs.add(KunItem("assets/image/kun/gif/gif_kun$i.gif"));
    }
    List<Widget> kunJpgs = [];
    for (int i = 0; i < 250; i++) {
      kunJpgs.add(KunItem("assets/image/kun/jpg/jpg_kun$i.jpg"));
    }
    List<Widget> kunJpegs = [];
    for (int i = 0; i < 127; i++) {
      kunJpegs.add(KunItem("assets/image/kun/jpeg/jpeg_kun$i.jpeg"));
    }
    List<Widget> kunWebps = [];
    for (int i = 0; i < 4; i++) {
      kunWebps.add(KunItem("assets/image/kun/webp/webp_kun$i.webp"));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            title: Text("头像区(${jis.length})"),
            children: [
              StaggeredGrid.extent(
                maxCrossAxisExtent: 80,
                children: jis,
              )
            ],
          ),
          ExpansionTile(
            title: Text("动图区(${kunGifs.length})"),
            children: [
              StaggeredGrid.extent(
                maxCrossAxisExtent: 150,
                children: kunGifs,
              )
            ],
          ),
          ExpansionTile(
            title: Text("表情包区1(${kunJpgs.length})"),
            children: [
              StaggeredGrid.extent(
                maxCrossAxisExtent: 150,
                children: kunJpgs,
              )
            ],
          ),
          ExpansionTile(
            title: Text("表情包区2(${kunJpegs.length})"),
            children: [
              StaggeredGrid.extent(
                maxCrossAxisExtent: 150,
                children: kunJpegs,
              )
            ],
          ),
          ExpansionTile(
            title: Text("表情包区3(${kunWebps.length})"),
            children: [
              StaggeredGrid.extent(
                maxCrossAxisExtent: 150,
                children: kunWebps,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

onItemClick(String path, context) {
  const textStyle = TextStyle(
      color: Colors.white,
      shadows: [Shadow(color: Colors.black, blurRadius: 2)]);
  showDialog(
      context: context,
      builder: (context) => Dialog(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              ListView(shrinkWrap: true, children: [
                Image.asset(path, fit: BoxFit.contain),
              ]),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("返回", style: textStyle),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              late PermissionStatus status;
                              if ((await DeviceInfoPlugin().androidInfo)
                                      .version
                                      .sdkInt <
                                  33) {
                                status = await Permission.storage.status;
                              } else {
                                status = await Permission.photos.status;
                              }

                              if (status.isGranted) {
                                var name = path.split('/').last;
                                var bytes = await rootBundle.load(path);
                                var tempPath =
                                    (await getTemporaryDirectory()).path + name;
                                await File(tempPath)
                                    .writeAsBytes(bytes.buffer.asUint8List());
                                var result = await GallerySaver.saveImage(
                                    tempPath,
                                    albumName: 'jibo');
                                if (result == true) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("已保存到:本地储存/Pictures/jibo/$name"),
                                  ));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("保存失败"),
                                  ));
                                }
                              } else if (status.isDenied) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("请允许访问储存空间"),
                                ));
                                if ((await DeviceInfoPlugin().androidInfo)
                                        .version
                                        .sdkInt <
                                    33) {
                                  await Permission.storage.request();
                                } else {
                                  await Permission.photos.request();
                                }
                              } else if (status.isPermanentlyDenied) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("请在设置中允许本应用访问储存空间"),
                                ));
                                await openAppSettings();
                              }
                            }
                          },
                          child: const Text(
                            "保存",
                            style: textStyle,
                          )),
                      TextButton(
                          onPressed: () async {
                            var data = await rootBundle.load(path);
                            var mimeType =
                                'image/${path.split('/').last.split('.').last}';
                            if (mimeType == 'image/jpg') {
                              mimeType = 'image/jpeg';
                            }
                            await Share.shareXFiles(
                              [
                                XFile.fromData(
                                    data.buffer.asUint8List(
                                        data.offsetInBytes, data.lengthInBytes),
                                    mimeType: mimeType,
                                    name: path.split('/').last),
                              ],
                            );
                          },
                          child: const Text(
                            "分享",
                            style: textStyle,
                          ))
                    ],
                  ),
                )
              ])
            ],
          )));
}

class JisItem extends StatelessWidget {
  final String path;
  const JisItem(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClick(path, context),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          path,
        ),
      ),
    );
  }
}

class KunItem extends StatelessWidget {
  final String path;
  const KunItem(this.path, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => onItemClick(path, context)),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          path,
        ),
      ),
    );
  }
}
