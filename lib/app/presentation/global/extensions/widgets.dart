import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  SliverToBoxAdapter get asSliveToBoxAdapter => SliverToBoxAdapter(child: this);
}
