import 'package:flatmates/const/colors.dart';
import 'package:flatmates/pages/splash_page.dart';
import 'package:flatmates/provider/chat_provider.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flatmates/provider/socket_io.dart';
import 'package:flatmates/provider/user_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const FlatMates());
}

class FlatMates extends StatelessWidget {
  const FlatMates({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FlatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SocketIo(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: customWhite,
          appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0.0, backgroundColor: customWhite),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: customWhite),
        ),
        home: SplashPage(),
      ),
    );
  }
}
