import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimerService {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  final service = FlutterBackgroundService();

  Future<void> initialize() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "pomodoro_timer_channel",
      'Pomodoro Timer',
      description: 'Muestra el progreso de la sesión actual',
      importance: Importance.low,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: false,
        notificationChannelId: 'pomodoro_timer_channel',
        initialNotificationContent: 'Iniciando sesión...',
        initialNotificationTitle: 'Pomodoro',
        foregroundServiceNotificationId: 888,
      ),
    );
  }

  Future<void> startTimer(int seconds) async {
    bool isRunning = await service.isRunning();

    if (!isRunning) {
      await service.startService();

      while (!(await service.isRunning())) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }

    service.invoke('setTimer', {'seconds': seconds});
  }

  void pauseTimer() {
    service.invoke('pauseTimer');
  }

  void killService() {
    service.invoke('killService');
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int remainingSeconds = 0;
  Timer? timer;

  service.on('setTimer').listen((event) {
    if (event != null && event.containsKey('seconds')) {
      remainingSeconds = event['seconds']!;

      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (t) async {
        if (remainingSeconds > 0) {
          remainingSeconds--;

          int minutes = remainingSeconds ~/ 60;
          int secs = remainingSeconds % 60;
          String timeString =
              "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";

          service.invoke('update', {
            'seconds': remainingSeconds,
            "formated": timeString,
          });

          flutterLocalNotificationsPlugin.show(
            id: 888,
            title: 'Sesión en progreso',
            body: 'Tiempo restante: $timeString',
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'pomodoro_timer_channel',
                'Pomodoro Timer',
                icon: '@mipmap/ic_launcher',
                ongoing: true,
                onlyAlertOnce: true,
              ),
            ),
          );
        } else {
          t.cancel();
          service.invoke('timerFinished');

          flutterLocalNotificationsPlugin.show(
            id: 889,
            title: '¡Tiempo terminado!',
            body: 'Tu ciclo ha concluido.',
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'pomodoro_alerts',
                'Pomodoro Alerts',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        }
      });
    }
  });

  service.on('pauseTimer').listen((event) {
    timer?.cancel();
  });

  service.on('killService').listen((event) {
    timer?.cancel();
    service.stopSelf();
  });
}
