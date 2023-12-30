import 'package:acim_helper/pages/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchPanel extends StatelessWidget {
  SearchPanel({Key? key}) : super(key: key);

  final controller = SearchController();
  final focusNode = FocusNode();
  // final tab = 'fuzzy'.obs;

  // late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final keyword = ''.obs;

    focusNode.requestFocus();

    // useEffect(() {
    //   focusNode.requestFocus();
    //   return null;
    // }, []);

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
                      keyword.value = value;
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
