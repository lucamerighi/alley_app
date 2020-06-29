import 'package:alley_app/services/allenamento_db.dart';
import 'package:alley_app/services/auth.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/eventi_db.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/turnocibo_db.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
  getIt.registerSingleton<AllenamentoDbService>(AllenamentoDbService());
  getIt.registerSingleton<PartiteDbService>(PartiteDbService());
  getIt.registerSingleton<EventiDbService>(EventiDbService());
  getIt.registerSingleton<TurnoCiboDbService>(TurnoCiboDbService());
}
