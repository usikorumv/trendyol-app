class CustomTabController {
  void onTap(int page) {
    for (var function in listeners) {
      function(page);
    }
  }

  List<Function(int)> listeners = [];
}
