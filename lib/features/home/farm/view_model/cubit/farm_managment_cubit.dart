import 'package:checkin/features/home/farm/repo/chicken_type_repo.dart';
import 'package:checkin/features/home/farm/view_model/cubit/farm_managment_state.dart';
import 'package:checkin/shared/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/farm_info_model.dart';
import '../../repo/farm_setup_repo.dart';

class FarmManagmentCubit extends Cubit<FarmManagmentState> {
  FarmManagmentCubit(this.repository, this.farmRepository) : super(FarmManagmentInitial());
  final FarmRepository farmRepository;
  final ChickenTypeRepository repository;
  TextEditingController farmController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();

  @override
  Future<void> close() {
    farmController.dispose(); 

    addressController.dispose();
    regionController.dispose();
    governorateController.dispose();
    return super.close();
  }


    void getAllFarms() async {
    emit(FarmLoading());
    try {
      final farms = await farmRepository.fetchFarms();
      emit(FarmSuccess(farms));
    } catch (e) {
      emit(FarmFailure(e.toString()));
    }
  }



 void createNewFarm(FarmModel farm) async {
    print("🧾 Sending Farm: ${farm.toJson()}");
  emit(FarmLoading());
  try {
    await farmRepository.addFarm(farm);
     emit(FarmAdded()); 
    final farms = await farmRepository.fetchFarms();
    emit(FarmSuccess(farms)); // 👈 مباشرة بعد الإضافة، نحدث القائمة
  } catch (e) {
    emit(FarmFailure(e.toString()));
  }
}
Future<void> updateFarm(int id, FarmModel farm) async {
  emit(FarmLoading());
  try {
    await farmRepository.editFarm(id, farm);
    final farms = await farmRepository.fetchFarms(); // إعادة تحميل
    emit(FarmSuccess(farms));
  } catch (e) {
    emit(FarmFailure(e.toString()));
  }
}

Future<void> deleteFarm(int id) async {
  emit(FarmLoading());
  try {
    await farmRepository.removeFarm(id);
    final farms = await farmRepository.fetchFarms(); // تحديث القائمة
    emit(FarmSuccess(farms));
  } catch (e) {
    emit(FarmFailure(e.toString()));
  }
}

 

  Future<void> getAllTypes() async {
    emit(ChickenTypeLoading());
    try {
      final types = await repository.getAll();
      emit(ChickenTypeLoaded(types));
    } catch (e) {
      emit(ChickenTypeError(e.toString()));
    }
  }

  Future<void> createType(String name) async {
    emit(ChickenTypeLoading());
    try {
      await repository.create(name);
      await getAllTypes(); // علشان نعمل تحديث بعد الإضافة
    } catch (e) {
      emit(ChickenTypeError(e.toString()));
    }
  }

  Future<void> updateType(int id, String name) async {
    emit(ChickenTypeLoading());
    try {
      await repository.update(id, name);
      await getAllTypes();
    } catch (e) {
      emit(ChickenTypeError(e.toString()));
    }
  }

  Future<void> deleteType(int id) async {
    emit(ChickenTypeLoading());
    try {
      await repository.delete(id);
      await getAllTypes();
    } catch (e) {
      emit(ChickenTypeError(e.toString()));
    }
  }
}
