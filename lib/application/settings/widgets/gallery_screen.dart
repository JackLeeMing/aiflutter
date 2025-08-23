import 'package:aiflutter/application/settings/utils/navigation.dart';
import 'package:aiflutter/application/settings/widgets/android_settings_screen.dart';
import 'package:aiflutter/application/settings/widgets/cross_platform_settings_screen.dart';
import 'package:aiflutter/application/settings/widgets/ios_developer_screen.dart';
import 'package:aiflutter/application/settings/widgets/web_chrome_settings.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: [
              SettingsTile.navigation(
                title: Text('Abstract settings screen'),
                leading: Icon(CupertinoIcons.wrench),
                description: Text('UI created to show plugin\'s possibilities'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: CrossPlatformSettingsScreen(),
                    style: NavigationRouteStyle.material,
                  );
                },
              )
            ],
          ),
          SettingsSection(
            title: Text('Replications'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(CupertinoIcons.settings),
                title: Text('iOS Developer Screen'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: IosDeveloperScreen(),
                    style: NavigationRouteStyle.cupertino,
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.settings),
                title: Text('Android Settings Screen'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: AndroidSettingsScreen(),
                    style: NavigationRouteStyle.material,
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.web),
                title: Text('Web Settings'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: WebChromeSettings(),
                    style: NavigationRouteStyle.material,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
