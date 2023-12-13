import 'package:flutter/material.dart';
import 'package:zendesk_messaging/zendesk_messaging.dart';
import 'package:zendesk_messaging_flutter/zendesk_fields.dart';

import 'app_constants.dart';
import 'app_context.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String androidChannelKey = '';
  final String iosChannelKey = '';

  @override
  void initState() {
    super.initState();
    ZendeskMessaging.initialize(
      androidChannelKey: androidChannelKey,
      iosChannelKey: iosChannelKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              onPressed: () => {
                ZendeskMessaging.show(),
                _setFields(),
                _setTags()
              },
              child: const Text("Show messaging"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ZendeskMessaging.initialize(
          androidChannelKey: androidChannelKey,
          iosChannelKey: iosChannelKey,
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _setFields() async {
    Map<String, String> fieldMaps = {};

    AppContext appContext = AppContext();
    ZendeskFields zendeskFields = appContext.getInfoToZendesk();
    //ZendeskFields zendeskFields = appContext.getFakeInfoToZendesk();

    fieldMaps[AppConstants.PROD_ZENDESK_ID_DEVICE_TYPE] = zendeskFields.deviceType;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_DEVICE_OS] = zendeskFields.deviceOSVersion;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_APP_VERSION] = zendeskFields.appVersionName;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_FULL_NAME] = zendeskFields.fullName;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_PHONE_NUMBER] = zendeskFields.phoneNumber;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_SITE] = zendeskFields.currentSite;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_MEAL_PLAN] = zendeskFields.mealPlanName;
    fieldMaps[AppConstants.PROD_ZENDESK_ID_COUNTRY] = zendeskFields.country;

    await ZendeskMessaging.setConversationFields(fieldMaps);
  }

  void _setTags() async {
    AppContext appContext = AppContext();
    ZendeskFields zendeskFields = appContext.getInfoToZendesk();
    //ZendeskFields zendeskFields = appContext.getFakeInfoToZendesk();
    final tags = [
      AppConstants.MOBILE_TICKET_TYPE_TAG,
      appContext.getDeviceOs(),
      zendeskFields.appBrand,
      zendeskFields.country
    ];

    await ZendeskMessaging.setConversationTags(tags);
  }
}
