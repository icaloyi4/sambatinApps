import 'package:sambatin/mvp/model/form_aduan_model.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/api/api_const.dart';
import 'package:sambatin/utils/api/api_helper.dart';
import 'package:sambatin/utils/api/response_model/get_responder_responder.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/global_widget.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class FormAduanPresenter {
  set view(FormAduanView v) {}
  Future<void> initServices() async {}
  Future<void> getResponder() async {}
}

class BasicFormAduanPresenter implements FormAduanPresenter {
  FormAduanView v;
  FormAduanModel m;
  ApiBaseHelper _helper;
  SettingService settingService;

  BasicFormAduanPresenter() {
    m = FormAduanModel();
    _helper = ApiBaseHelper();
  }

  @override
  Future<void> initServices() async {
    settingService = await SettingService.getService();
    getResponder();
  }

  @override
  set view(FormAduanView v) {
    this.v = v;
    v.refreshView(m);
  }

  @override
  Future<void> getResponder() async {
    try {
      final responder = await _helper.post(
          MyApiConst.searchfollowinguser,
          {},
          {
            'id_user' : userData.data[0].id.toString(),
          }
      );
      final kontenData = GetResponderResponse.fromJson(responder);
      if(kontenData.data.isNotEmpty){
        m.listResponder.addAll(kontenData.data);
      } else {
        showSnackbar(m.scaffoldKey, 'Tidak ada aduan');
      }
    } catch (e) {
      print(e);
      showSnackbar(m.scaffoldKey, 'Error $e');
    } finally {
      v.refreshView(m);
    }
  }
}