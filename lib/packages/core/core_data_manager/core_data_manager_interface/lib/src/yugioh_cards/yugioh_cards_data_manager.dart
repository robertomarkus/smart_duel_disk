import '../../core_data_manager_interface.dart';

abstract class YugiohCardsDataManager {
  Future<Iterable<YugiohCard>> getSpeedDuelCards({bool includeSkillCards = false});
}
