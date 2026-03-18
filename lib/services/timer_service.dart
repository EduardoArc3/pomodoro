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
        autoStart: true,
        notificationChannelId: 'pomodoro_timer_channel',
        initialNotificationContent: 'Iniciando sesión...',
        initialNotificationTitle: 'Pomodoro',
        foregroundServiceNotificationId: 888,
      ),
    );
  }

  void startTimer(int seconds) {
    service.startService();
    service.invoke('setTimer', {'seconds': seconds});
  }

  void stopTimer() {
    service.invoke('stopService');
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
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
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
                icon: 'ic_bg_service_small',
                ongoing: true,
                onlyAlertOnce: true,
              ),
            ),
          );
        } else {
          timer.cancel();
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

          service.stopSelf();
        }
      });
    }
  });

  service.on('stopService').listen((event) {
    timer?.cancel();
    service.stopSelf();
  });
}
