import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_widgets/components/listView_widget.dart';
import 'package:flutter_widgets/components/permission_test.dart';
import 'package:flutter_widgets/components/sqlite/perosn_provider.dart';
import 'package:flutter_widgets/components/sqlite/person_list_page.dart';
import 'package:flutter_widgets/components/url_launcher_page.dart';
import 'package:flutter_widgets/custom/actionBar_test.dart';
import 'package:flutter_widgets/custom/menuGroup_test.dart';
import 'package:flutter_widgets/element/animation/animatedbuilder/animated_builder.dart';
import 'package:flutter_widgets/element/animation/animation/custom_animated_page.dart';
import 'package:flutter_widgets/element/game/game_list.dart';
import 'package:flutter_widgets/element/media/icon_widget.dart';
import 'package:flutter_widgets/learning/draw/03/03_canvas_page.dart';
import 'package:flutter_widgets/learning/draw/03/05_canvas_page.dart';
import 'package:flutter_widgets/learning/draw/04/06_canvas_page.dart';
import 'package:flutter_widgets/learning/draw/04/07_canvas_page.dart';
import 'package:flutter_widgets/learning/draw/05/01_path_page.dart';
import 'package:rxdart/rxdart.dart';

import 'components/appBar_widget.dart';
import 'components/bar_main.dart';
import 'components/connectivity_test.dart';
import 'components/device_info_page.dart';
import 'components/dialog_main.dart';
import 'components/grid_widget.dart';
import 'components/listView_widget.dart';
import 'components/menu_widget.dart';
import 'components/navigation_widget.dart';
import 'components/notifications_test.dart';
import 'components/picker_main.dart';
import 'components/progress_widget.dart';
import 'components/scroll/customScrollView_widget.dart';
import 'components/scroll/scrollVIew_listener.dart';
import 'components/scroll/scroll_main.dart';
import 'components/scroll/singleChildScrollView_widget.dart';
import 'components/svg_view.dart';
import 'components/tab_widget.dart';
import 'components/tree_view.dart';
import 'custom/dtail_listview_test.dart';
import 'custom/refreshListView_test.dart';
import 'custom/searchPanel_test.dart';
import 'custom/stateView_test.dart';
import 'element/animation/animatedwidget/animation_widget.dart';
import 'element/animation/animation_list.dart';
import 'element/form/button_widget.dart';
import 'element/form/checkbox_widget.dart';
import 'element/form/form_main.dart';
import 'element/form/input_widget.dart';
import 'element/form/radio_widget.dart';
import 'element/form/switch_widget.dart';
import 'element/form/text_widget.dart';
import 'element/frame/align_widget.dart';
import 'element/frame/frame_main.dart';
import 'element/frame/layout_widget.dart';
import 'element/frame/stack_widget.dart';
import 'element/frame/table_widget.dart';
import 'element/media/image_widget.dart';
import 'element/media/media_main.dart';
import 'learning/draw/01/custom_paint_test.dart';
import 'learning/draw/02/01_paint_page.dart';
import 'learning/draw/03/01_canvas_page.dart';
import 'learning/draw/03/02_canvas_page.dart';
import 'learning/draw/03/04_canvas_page.dart';
import 'learning/draw/05/02_path_page.dart';
import 'learning/draw/draw_list.dart';

///
/// 数据库配置
///
late DbPersonProvider personProvider;

///
///
/// 通知栏配置
///
///
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
BehaviorSubject<String?>();

const MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

///
///
/// 通知栏配置
///
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// 初始化数据类配置
  ///
  personProvider = DbPersonProvider();
  await personProvider.ready;

  ///
  /// 初始化通知栏配置
  ///
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = "/";

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;
    initialRoute = NotificationDetailPage.routeName;
  }
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      });



  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;


  MyApp(this.initialRoute); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => MyHomePage(),
        'form_main': (context) => FormMain(),
        'input_widget': (context) => InputWidget(),
        'checkbox_widget': (context) => CheckBoxWidget(),
        'button_widget': (context) => ButtonWidget(),
        'text_widget': (context) => TextWidget(),
        'radio_widget': (context) => RadioWidget(),
        'switch_widget': (context) => SwitchWidget(),
        'frame_main': (context) => FrameMain(),
        'align_widget': (context) => AlignWidget(),
        'stack_widget': (context) => StackWidget(),
        'layout_widget': (context) => LayoutWidget(),
        'table_widget': (context) => TableWidget(),
        'media_main': (context) => MediaMain(),
        'image_widget': (context) => ImageWidget(),
        'animation_list': (context) => CustomAnimatedPage(),
        'animation_page': (context) => AnimationPage(),
        'animated_widget': (context) => AnimationWidget(),
        'animated_builder': (context) => AnimatedBuilderPage(),
        'games': (context) => GameListPage(),
        'navigation_widget': (context) => NavigationWidget(),
        'listView_widget': (context) => ListViewDemoWidget(),
        'bar_main': (context) => BarMain(),
        'appBar_widget': (context) => AppBarWidget(),
        'tab_widget': (context) => TabWidget(),
        'dialog_main': (context) => DialogMain(),
        'grid_widget': (context) => GridWidget(),
        'scroll_main': (context) => ScrollMain(),
        'singleChildScrollView_widget': (context) => SingleChildScrollViewWidget(),
        'customScrollView_widget': (context) => CustomScrollViewTestRoute(),
        'scrollVIew_listener': (context) => ScrollControllerTestRoute(),
        'menu_widget': (context) => MenuMain(),
        'picker_main': (context) => PickerMain(),
        'progress_widget': (context) => ProgressMain(),
        'refresh_listView': (context) => RefreshListViewTest(),
        'stateView_test': (context) => StateViewTest(),
        'searchPanel_test': (context) => ExpansionPanelPage(),
        'tree_test': (context) => TreeWidgetView(),
        'svg_test': (context) => SvgTest(),
        'menuGroup_test': (context) => MenuGroupPage(),
        'icon_test': (context) => IconWidget(),
        'actionBar_test': (context) => ActionBarPage(),
        'detailListView_test': (context) => DetailListViewTest(),
        'connectivity_test': (context) => ConnectivityPage(),
        'sqlite_test': (context) => PersonListPage(),
        'device_info_test': (context) => DeviceInfoPage(),
        'url_launcher_test': (context) => UrlLauncherPage(),
        'permission_test': (context) => PermissionPage(),
        'draw_list': (context) => DrawListPage(),
        'custom_paint_test': (context) => CustomPaintPage(),
        '01_paint_page': (context) => PaintPage01(),
        '01_canvas_page': (context) => CanvasPage01(),
        '02_canvas_page': (context) => CanvasPage02(),
        '03_canvas_page': (context) => CanvasPage03(),
        '04_canvas_page': (context) => CanvasPage04(),
        '05_canvas_page': (context) => CanvasPage05(),
        '06_canvas_page': (context) => CanvasPage06(),
        '07_canvas_page': (context) => CanvasPage07(),
        '01_path_page': (context) => PathPage01(),
        '02_path_page': (context) => PathPage02(),
        NotificationTestPage.routeName: (_) => NotificationTestPage(),
        NotificationDetailPage.routeName: (_) => NotificationDetailPage(selectedNotificationPayload)
      },
      initialRoute: initialRoute,
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        NotificationDetailPage(receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, '/secondPage');
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("flutter widgets"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Element:',
                style: TextStyle(fontSize: 20),
              ),
              itemView(context, "From", "form_main"),
              itemView(context, "Frame", "frame_main"),
              itemView(context, "Media", "media_main"),
              itemView(context, "Animation", "animation_list"),
              itemView(context, "games", "games"),

              SizedBox(height: 24,),
              Text(
                'Components:',
                style: TextStyle(fontSize: 20),
              ),
              itemView(context, "Navigation", "navigation_widget"),
              itemView(context, "List", "listView_widget"),
              itemView(context, "Card", ""),
              itemView(context, "Bar", "bar_main"),
              itemView(context, "Dialog", "dialog_main"),
              itemView(context, "Scaffoid", ""),
              itemView(context, "Grid", "grid_widget"),
              itemView(context, "Scroll", "scroll_main"),
              itemView(context, "Tab", "tab_widget"),
              itemView(context, "Menu", "menu_widget"),
              itemView(context, "Pick", "picker_main"),
              itemView(context, "Chip", ""),
              itemView(context, "Panel", ""),
              itemView(context, "Progress", "progress_widget"),
              itemView(context, "Svg", "svg_test"),
              itemView(context, "TreeView", "tree_test"),
              itemView(context, "Connectivity", "connectivity_test"),
              itemView(context, "Sqflite", "sqlite_test"),
              itemView(context, "Device Info", "device_info_test"),
              itemView(context, "url_launcher", "url_launcher_test"),
              itemView(context, "notification", NotificationTestPage.routeName),
              itemView(context, "permission", "permission_test"),

              SizedBox(height: 24,),
              Text(
                'Custom:',
                style: TextStyle(fontSize: 20),
              ),
              itemView(context, "RefreshListView", "refresh_listView"),
              itemView(context, "StateView", "stateView_test"),
              itemView(context, "SearchPanel", "searchPanel_test"),
              itemView(context, "MenuGroup", "menuGroup_test"),
              itemView(context, "ActionBar", "actionBar_test"),
              itemView(context, "DetailListView", "detailListView_test"),

              SizedBox(height: 24,),
              Text(
                'Learning:',
                style: TextStyle(fontSize: 20),
              ),
              itemView(context, "Draw", "draw_list"),

            ],
          ),
        ),
      ),
    );
  }

  Widget itemView(BuildContext context, String title, String pageRoute) {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        child: Text(title),
        onPressed: () {
          if(pageRoute.isNotEmpty) {
            Navigator.pushNamed(context, pageRoute);
          }
        },
      ),
    );
  }
}
