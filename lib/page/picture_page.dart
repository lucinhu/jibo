import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({super.key});
  @override
  Widget build(BuildContext context) {
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
}

class JisItem extends StatelessWidget {
  final String path;
  const JisItem(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        path,
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
      onTap: (() async {}),
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
