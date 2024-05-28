import 'package:cuida_pet_back_end/application/routers/I_router_config.dart';
import 'package:cuida_pet_back_end/modules/teste/teste_controller.dart';
import 'package:shelf_router/shelf_router.dart';

class TesteRouter  implements IRouterConfig{
  @override
  void configure(Router route) {
    route.mount("/",TesteController().router);
  }
}