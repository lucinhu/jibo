import 'package:dio/dio.dart';
import 'package:jibo/api/api_constants.dart';
import 'package:jibo/model/github_releases_item.dart';

class GithubApi {
  static Future<GithubReleasesItemModel> requestLatestRelease() async {
    var response = await Dio().get(ApiConstants.githubLatestRelease);
    return GithubReleasesItemModel.fromJson(response.data);
  }
}
