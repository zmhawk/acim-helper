import 'package:acim_helper/models/data.dart';
import 'package:get/state_manager.dart';

// 当前展示的 item
//
// 该值在以下场景中被修改：
// 1. 左右滑动、翻页
// 2. 页面刷新时，即 drawItem 被修改时
final viewItem = Rx<DataItem>(DataItem(-1, '', ''));
