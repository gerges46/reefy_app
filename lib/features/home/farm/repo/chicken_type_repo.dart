
// import '../model/checken_type_model.dart';
// import '../services/chicken_type_service.dart';

// class ChickenTypeRepository {
//   final ChickenTypeService service;

//   ChickenTypeRepository(this.service);

//   Future<List<ChickenTypeModel>> getAll() async {
//     return await service.getAllChickenTypes();
//   }

//   Future<void> create(String name) async {
//     await service.createChickenType(name);
//   }

//   Future<void> update(int id, String name) async {
//     await service.updateChickenType(id, name);
//   }

//   Future<void> delete(int id) async {
//     await service.deleteChickenType(id);
//   }
// }
import '../services/chicken_type_service.dart';

class ChickenTypeRepository {
  final ChickenTypeService service;
  ChickenTypeRepository(this.service);

  Future<void> create(String name) => service.create(name);
  Future<List<String>> getAll() => service.getAll();
  Future<void> update(int id, String name) => service.update(id, name);
  Future<void> delete(int id) => service.delete(id);
}
