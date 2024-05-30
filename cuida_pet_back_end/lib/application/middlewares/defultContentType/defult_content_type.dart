


import 'package:cuida_pet_back_end/application/middlewares/Middlewares.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

class DefultContentType  extends Middlewares {

  final String contentype;

  DefultContentType({required this.contentype});
  @override
  Future<Response> execute(Request request)async {
    final response = await innerHandler(request);
    return response.change(headers: {'content-type': contentype});
  }
  
  
}