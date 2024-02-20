import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_study_case/features/auth/login/view/login_view.dart';
import 'package:voco_study_case/features/home/participants/view/participants_view.dart';
import 'package:voco_study_case/product/service/service_locater.dart';
import 'package:voco_study_case/product/init/application_initialize.dart';
import 'package:voco_study_case/product/repository/local/local_storage_token.dart';

import 'product/navigation/project_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationInitialize().start();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: (setting) => ProjectProuter.generateRoute(setting),
      home: FutureBuilder<String>(
          future: ServiceLocator.read<LocalStorageToken>().getToken(),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return snap.data!.isNotEmpty
                  ? const ParticipantsView()
                  : const LoginView();
            }
            return const SizedBox();
          }),
    );
  }
}
