class FullScreenArguments {
  List<String>? list;
  int? selectedIndex;

  FullScreenArguments({this.list, this.selectedIndex});

  String get item => list![selectedIndex!];
}
