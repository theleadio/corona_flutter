import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:intl/intl.dart';

class Helper {
  static void openArticle({
    String url,
    BuildContext context,
  }) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static String formatDate(String timestamp) {
    return DateFormat.yMMMEd().add_jm().format(DateTime.parse(timestamp));
  }
}
