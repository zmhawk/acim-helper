import 'package:acim_helper/models/data.dart';
import 'package:get/state_manager.dart';

// 页面每次刷新时的值
//
// 该值在以下场景中被修改：
// 1. 点击搜索结果列表中的某一项
// 2. 点击历史记录列表中的某一项
// 3. 点击主页的抽卡按钮
// 4. 页面首次加载
final drawItem = Rx<DataItem>(DataItem(-1, '', ''));
