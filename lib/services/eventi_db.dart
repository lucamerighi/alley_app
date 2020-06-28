import 'package:alley_app/model/evento.dart';
import 'package:alley_app/services/allenamento_db.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/service_locator.dart';

class EventiDbService {
  final PartiteDbService partiteDb = getIt<PartiteDbService>();
  final AllenamentoDbService allenamentiDb = getIt<AllenamentoDbService>();

  Future<List<Evento>> getEventi(String idSquadra) async {
    var partite = await partiteDb.getPartite(idSquadra);
    var allenamenti = await allenamentiDb.getPracticesList(idSquadra);
    return List<Evento>.from(partite)..addAll(allenamenti);
  }
}
