import 'dart:developer';

import 'package:acim_helper/pages/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = SearchController();
    ThemeData theme = Theme.of(context);
    final cachedKeyword = GetStorage().read('keyword');
    final inputValue = RxString(cachedKeyword ?? '');
    final keyword = RxString(cachedKeyword ?? '');
    debounce(inputValue, (value) => keyword.value = value,
        time: const Duration(milliseconds: 100));

    log('SearchPanel');

    final focusNode = FocusNode();
    focusNode.requestFocus();

    ever(inputValue,
        (callback) => GetStorage().write('keyword', inputValue.value));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          flexibleSpace: SafeArea(
              child: Container(
                  margin: const EdgeInsets.only(
                      left: 56, right: 56, top: 12, bottom: 12),
                  // height: 24,
                  child: TextField(
                    // controller: _controller,
                    focusNode: focusNode,
                    style: theme.searchViewTheme.headerTextStyle,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: '搜索'),
                    onChanged: (value) {
                      inputValue.value = value;
                    },
                  ))),
          bottom: const TabBar(
            tabs: [
              Tab(text: '模糊搜索'),
              Tab(text: '精确搜索'),
            ],
          ),
        ),
        body: TabBarView(children: [
          Obx(() => SearchResultList(
                keyword: keyword.value,
                tab: 'fuzzy',
              )),
          Obx(() => SearchResultList(
                keyword: keyword.value,
                tab: 'exact',
              )),
        ]),
      ),
    );
  }
}
