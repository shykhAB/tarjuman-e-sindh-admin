
import 'package:get/get.dart';
import '../../utils/log.dart';
import '../../utils/user_session.dart';

class DropdownController {

  final RxString errorMessage=''.obs;
  final Rx<dynamic> selectedItem=Rx(null);
  String title;
  String hintText;
  final RxList<dynamic> items;

  bool mandatory;
  final bool withNumericField;


  DropdownController({required this.title, required this.items, this.mandatory=true,  this.hintText='', this.withNumericField = false});

  bool validate(){
    if(selectedItem.value == null){
      errorMessage.value = mandatory ?"Please select $title" : '';
    } else {
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    }
    if(errorMessage.isNotEmpty) Log.debug('Dropdown: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  void setFirstItem(){
    if(items.isNotEmpty) {
      selectedItem.value = items.first;
    }
  }

  void clear(){
    items.clear();
    selectedItem.value = null;
  }

}
