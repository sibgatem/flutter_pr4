import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());
  int count = 0;
  List<String> list = <String>[];

  void onClick(ThemeMode themeMode) {
    themeMode == ThemeMode.light ? count++ : count += 2;
    list.add("count: $count, theme: ${themeMode.name}");
    emit(Click(count));
  }
}
