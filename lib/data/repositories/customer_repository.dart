import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/customer_model.dart';

class CustomerRepository {
  final ApiClient _apiClient;

  CustomerRepository(this._apiClient);

  Future<CustomerModel> getById(int customerId) async {
    final json = await _apiClient.get('${ApiConstants.customer}/$customerId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return CustomerModel.fromJson(json);
  }

  Future<List<CustomerModel>> getAll(Map<String, String>? params) async {
    final data = await _apiClient.get(ApiConstants.customer, query: params);
    if (data is! List) throw ParsingException();

    return data
        .map((json) => CustomerModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
