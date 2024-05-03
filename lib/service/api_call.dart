import 'package:finding_flacone/import.dart';

class ApiCall extends GetConnect {
  // Get request
  Future<Response> getPlanets() async {
    print("🍄");
    var data = await get('https://findfalcone.geektrust.com/planets');
    return data;
  }

  Future<Response> getVehicles() async {
    return await get('https://findfalcone.geektrust.com/vehicles');
  }

  // Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', data);

  Future<Response<dynamic>> postToken() {
    final headers = {
      'Accept': 'application/json',
    };
    return post('https://findfalcone.geektrust.com/token', {},
        headers: headers);
  }

  // @override
  // Future<Response<dynamic>> postFindFalcone(ModelName model) {
  //   return post('find', jsonEncode(model.toJson()));
  // }
}
