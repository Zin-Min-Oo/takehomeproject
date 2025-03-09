import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takehomeproject/views/widgets/toast_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'views/pages/splash_page.dart';
import 'views/pages/home_page.dart';
import 'views/pages/login_page.dart';
import 'views/pages/signup_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAX6601AIUjNryYwHvJuv8xJING57V4ohk",
      appId: "1:17290118173:android:8c71d61b1df662dd6b72f4",
      messagingSenderId: "17290118173",
      projectId: "takehomeproject-5fab8",
      storageBucket: "takehomeproject-5fab8.firebasestorage.app",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkInitialConnection(); // Check initial connection when app starts
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  /// Check initial internet connection status
  Future<void> _checkInitialConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  /// Handle changes in connectivity status
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result;
    });

    if (result == ConnectivityResult.none) {
      showToast(message: "❌ No Internet Connection");
    } else {
      showToast(message: "✅ Internet Available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Home Project',
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashPage(child: LoginPage()),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (_connectionStatus == ConnectivityResult.none)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.white,
                          size: 150.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "No Internet Connection",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
