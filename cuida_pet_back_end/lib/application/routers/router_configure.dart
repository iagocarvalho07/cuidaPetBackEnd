import 'package:cuida_pet_back_end/modules/teste/teste.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:cuida_pet_back_end/application/routers/I_router_config.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouterConfig> _routers = [
    TesteRouter(),
  ];

  RouterConfigure(this._router);

  void configure() => _routers.forEach((element) => element.configure(_router));
}
