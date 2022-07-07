class CustomTabController {
  void onTap(int page) {
    listeners.forEach((function) {
      function(page);
    });
  }

  List<Function(int)> listeners = [];
}
