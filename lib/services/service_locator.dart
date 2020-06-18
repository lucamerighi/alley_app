import 'package:alley_app/services/auth.dart';
import 'package:alley_app/services/database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
