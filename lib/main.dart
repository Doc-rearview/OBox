import 'package:flutter/material.dart';
import 'package:OBOX/providers/entry.dart';
import 'package:OBOX/providers/watchlist.dart';
import 'package:OBOX/screens/navigation.dart';
import 'package:OBOX/screens/onboarding.dart';
import 'package:provider/provider.dart';
// import 'package:appwrite/appwrite.dart';

// import 'environment.dart';
import 'providers/account.dart';
// import 'providers/entry.dart';

// class AppwriteService {
//   final Client client = Client()
//     ..setEndpoint(Environment.endpoint)
//     ..setProject(Environment.projectId);

//   late final Account account = Account(client);
//   late final Databases databases = Databases(client);
//   late final Storage storage = Storage(client);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => EntryProvider()),
        ChangeNotifierProvider(create: (context) => WatchListProvider()),
      ],
      child: const Main(),
    )
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBOX',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: context.read<AccountProvider>().isValid(),
        builder: (context, snapshot) => context.watch<AccountProvider>().session == null ? const OnboardingScreen() : const NavScreen(),
      )
    );
  }
}
// 

