import 'package:sambatin/mvp/model/dashboard_model.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/api/api_const.dart';
import 'package:sambatin/utils/api/api_helper.dart';
import 'package:sambatin/utils/api/response_model/user_content_response.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/global_widget.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class DashboardPresenter {
  set view(DashboardView v) {}
  Future<void> initServices() async {}
  Future<void> getKonten() async {}
}

class BasicDashboardPresenter implements DashboardPresenter {

  DashboardView v;
  DashboardModel m;
  ApiBaseHelper _helper;
  SettingService settingService;

  BasicDashboardPresenter() {
    m = DashboardModel();
    _helper = ApiBaseHelper();
  }

  @override
  Future<void> initServices() async {
    settingService = await SettingService.getService();
    getKonten();
  }

  @override
  set view(DashboardView v) {
    this.v = v;
    v.refreshView(m);
  }

  @override
  Future<void> getKonten() async {
    m.isAmbilKonten = true;
    v.refreshView(m);
    try {
      final konten = await _helper.post(
          MyApiConst.getContentBaseUser,
          {},
          {
            'id_user' : userData.data[0].id.toString(),
          }
      );
      final kontenData = UserContentResponse.fromJson(konten);
      if(kontenData.data.isNotEmpty){
        m.konten.addAll(kontenData.data);
      } else {
        showSnackbar(m.scaffoldKey, 'Tidak ada aduan');
      }
    } catch (e) {
      print(e);
      showSnackbar(m.scaffoldKey, 'Error $e');
    } finally {
      m.isAmbilKonten = false;
      v.refreshView(m);
    }
  }

}