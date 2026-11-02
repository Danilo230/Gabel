import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/data/models/paged_result_model.dart';

class CustomerRepository {
  final ApiClient _apiClient;

  CustomerRepository(this._apiClient);

  Future<CustomerModel> getById(int customerId) async {
    final json = await _apiClient.get('${ApiConstants.customer}/$customerId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return CustomerModel.fromJson(json);
  }

  Future<PagedResultModel<CustomerModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.customer, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, CustomerModel.fromJson);
  }

  Future<CustomerModel> create(CustomerModel customer) async {
    final json = await _apiClient.post(
      ApiConstants.customer,
      body: {
        'customerName': customer.customerName,
        'customerLastName': customer.customerLastName,
        'customerPhone': customer.customerPhone,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return CustomerModel.fromJson(json);
  }

  Future<CustomerModel> updateCustomer(
    int customerId,
    CustomerModel customer,
  ) async {
    final json = await _apiClient.put(
      '${ApiConstants.customer}/$customerId',
      body: {
        'customerName': customer.customerName,
        'customerLastName': customer.customerLastName,
        'customerPhone': customer.customerPhone,
        'customerStatus': customer.customerStatus,
      },
    );
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return CustomerModel.fromJson(json);
  }

  Future<String> delete(int customerId, bool customerStatus) async {
    final json = await _apiClient.delete(
      '${ApiConstants.customer}/DeleteCustomer/$customerId',
      body: {'customerStatus': customerStatus},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return json['message'] as String;
  }
}
