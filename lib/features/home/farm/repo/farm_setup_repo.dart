
import '../model/farm_info_model.dart';
import '../services/farm_setup_services.dart';

class FarmRepository {
  final FarmService service;
  FarmRepository(this.service);

  Future<void> addFarm(FarmModel farm) => service.createFarm(farm);
  Future<List<FarmModel>> fetchFarms() => service.getFarms();
  Future<FarmModel> fetchFarmById(int id) => service.getFarmById(id);
  Future<void> editFarm(int id, FarmModel farm) => service.updateFarm(id, farm);
  Future<void> removeFarm(int id) => service.deleteFarm(id);
}

