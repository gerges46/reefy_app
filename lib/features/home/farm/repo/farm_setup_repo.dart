import '../model/farm_info_model.dart';
import '../services/farm_setup_services.dart';

class FarmRepository {
  final FarmService _service;

  FarmRepository(this._service);

  Future<void> createFarm(FarmModel farm) => _service.createFarm(farm);
  Future<void> updateFarm(int id, FarmModel farm) => _service.updateFarm(id, farm);
  Future<void> deleteFarm(int id) => _service.deleteFarm(id);
  Future<List<FarmModel>> getUserFarms(int userId) => _service.getUserFarms(userId);
}
