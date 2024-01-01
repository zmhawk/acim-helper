import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/state_manager.dart';
import 'package:version/version.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_linkify/flutter_linkify.dart';

String getVersion() {
  try {
    return const String.fromEnvironment('VERSION') ?? '未知';
  } catch (e) {
    return '未知';
  }
}

class Assets {
  String browserDownloadUrl;

  Assets(this.browserDownloadUrl);

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      json['browser_download_url'] as String,
    );
  }
}

class GitHubLatest {
  String tagName;
  String publishedAt;
  List<Assets> assets;

  GitHubLatest(this.tagName, this.publishedAt, this.assets);

  factory GitHubLatest.fromJson(Map<String, dynamic> json) {
    return GitHubLatest(
      json['tag_name'],
      json['published_at'],
      (json['assets'] as List).map((e) => Assets.fromJson(e)).toList(),
    );
  }
}

Future<GitHubLatest> getLatest() async {
  final response = await http.get(Uri.parse(
      'https://api.github.com/repos/zmhawk/acim-helper/releases/latest'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    try {
      return GitHubLatest.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load version');
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load version');
  }
}

Future<bool> checkUpdate() async {
  final latest = await getLatest();
  Version currentVersion = Version.parse(getVersion());
  Version latestVersion = Version.parse(latest.tagName);
  if (latestVersion > currentVersion) {
    return true;
  }
  return false;
}

class CheckUpdate extends GetxController {
  GitHubLatest? latest;
  bool loading = false;

  void fetch() async {
    loading = true;
    update();
    log('getLatest start');
    latest = await getLatest();
    log('getLatest end');

    loading = false;
    update();
  }

  String getDownloadUrl() {
    final arm64 = latest!.assets.singleWhere(
        (element) => element.browserDownloadUrl.contains('arm64-v8a'));
    return arm64.browserDownloadUrl;
  }

  String getDate() {
    final date = DateTime.parse(latest!.publishedAt);
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}

class VersionDialog extends StatelessWidget {
  const VersionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('VersionDialog');
    return GetBuilder<CheckUpdate>(
      init: CheckUpdate(),
      builder: (s) {
        return AlertDialog(
          title: const Text('检查更新'),
          content: SizedBox(
            height: 200,
            width: 300,
            child: s.loading
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('当前版本：${getVersion()}'),
                      const Text(''),
                      Text('最新版本：${s.latest!.tagName}'),
                      Text('发布时间：${s.getDate()}'),
                      const Linkify(
                          text:
                              '下载链接：https://yu-public-hongkong.oss-cn-hongkong.aliyuncs.com/acim-helper.apk'),
                      const Linkify(
                          text:
                              '（如链接失效，请前往微信公众号“逆行者的奇迹漫谈”或项目地址 https://github.com/zmhawk/acim-helper 获取最新下载链接）')
                    ],
                  ),
          ),
        );
      },
    );
  }
}
