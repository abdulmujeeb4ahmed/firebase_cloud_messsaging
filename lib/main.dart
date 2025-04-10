import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

class NotificationItem {
  final String title;
  final String body;
  final String type;
  final DateTime receivedAt;

  NotificationItem({
    required this.title,
    required this.body,
    required this.type,
    required this.receivedAt,
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Background message received: ${message.notification?.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MessagingTutorial());
}

class MessagingTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Firebase Messaging Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging _messaging;
  final List<NotificationItem> _notificationHistory = [];

  @override
  void initState() {
    super.initState();

    _messaging = FirebaseMessaging.instance;

    _messaging.subscribeToTopic("messaging");

    _messaging.getToken().then((token) {
      print("FCM Token: $token");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.messageId}");

      String type =
          message.data['notificationType']?.toLowerCase() ?? 'regular';

      String title = message.notification?.title ?? "No Title";
      String body = message.notification?.body ?? "No Body";

      final newItem = NotificationItem(
        title: title,
        body: body,
        type: type,
        receivedAt: DateTime.now(),
      );
      setState(() {
        _notificationHistory.add(newItem);
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              type == 'important' ? "Important Notification" : "Notification",
              style: TextStyle(
                color: type == 'important' ? Colors.red : Colors.black,
                fontWeight:
                    type == 'important' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  type == 'important' ? Icons.warning : Icons.info,
                  color: type == 'important' ? Colors.red : Colors.blue,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(body),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => NotificationHistoryScreen(
                            history: _notificationHistory,
                          ),
                    ),
                  );
                },
                child: const Text("View History"),
              ),
            ],
          );
        },
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened: ${message.notification?.body}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => NotificationHistoryScreen(
                        history: _notificationHistory,
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text("Firebase Messaging Demo")),
    );
  }
}

class NotificationHistoryScreen extends StatelessWidget {
  final List<NotificationItem> history;
  const NotificationHistoryScreen({Key? key, required this.history})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification History")),
      body:
          history.isEmpty
              ? const Center(child: Text("No notifications received yet."))
              : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Icon(
                        item.type == 'important' ? Icons.warning : Icons.info,
                        color:
                            item.type == 'important' ? Colors.red : Colors.blue,
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.body),
                      trailing: Text(
                        "${item.receivedAt.hour.toString().padLeft(2, '0')}:${item.receivedAt.minute.toString().padLeft(2, '0')}",
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
