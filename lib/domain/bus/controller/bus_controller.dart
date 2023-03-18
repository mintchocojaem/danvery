
import 'package:get/get.dart';

import '../model/bus_model.dart';
import '../repository/bus_repository.dart';


class BusController extends GetxController {

  final BusRepository busRepository;

  BusController({required this.busRepository});

  final RxList<BusModel> busListOfJungMoon = <BusModel>[].obs;
  final RxList<BusModel> busListOfGomSang = <BusModel>[].obs;

  final RxBool _isLoadBustList = false.obs;

  bool get isLoadBusList => _isLoadBustList.value;

  @override
  void onInit() {
    getBustList();
    super.onInit();
  }

  void getBustList() {
    busRepository.getBusListFromStation("단국대정문").then((value) {
      if (value != null) {
        busListOfJungMoon.value = value;
        busRepository.getBusListFromStation("곰상").then((value) {
          if(value != null){
            busListOfGomSang.value = value;
            if(busListOfJungMoon.isNotEmpty && busListOfGomSang.isNotEmpty){
              _isLoadBustList.value = true;
            }
          }
        });
      }
    });
  }

  void refreshBusList(){
    getBustList();
  }

  BusModel findJungMoonBusByNo(String no){
    return busListOfJungMoon.firstWhere((p0) => p0.busNo == no);
  }

  BusModel findGomSangBusByNo(String no){
    return busListOfGomSang.firstWhere((p0) => p0.busNo == no);
  }

}
