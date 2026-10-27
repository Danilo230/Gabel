import 'package:gabel/core/constants/regular_expressions.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/data/repositories/customer_repository.dart';

class CustomerService {
  final CustomerRepository _customerRepository;

  CustomerService(this._customerRepository);

  Future<CustomerModel> getById(int customerId) async {
    return await _customerRepository.getById(customerId);
  }

  Future<List<CustomerModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    return await _customerRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<CustomerModel> create(CustomerModel customer) async {
    final name = customer.customerName.trim();
    final lastName = customer.customerLastName.trim();
    final phone = customer.customerPhone.trim();
    final trimmedPhone = customer.customerPhone.trim();

    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }
    return await _customerRepository.create(
      CustomerModel(
        customerId: customer.customerId,
        customerName: name,
        customerLastName: lastName,
        customerPhone: phone,
        customerStatus: true,
      ),
    );
  }

  Future<CustomerModel> update(int customerId, CustomerModel customer) async {
    final name = customer.customerName.trim();
    final lastName = customer.customerLastName.trim();
    final phone = customer.customerPhone.trim();

    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }
    return await _customerRepository.create(
      CustomerModel(
        customerId: customerId,
        customerName: name,
        customerLastName: lastName,
        customerPhone: phone,
        customerStatus: customer.customerStatus,
      ),
    );
  }

  Future<String> delete(int customerId, bool customerStatus) async {
    if (customerId <= 0) {
      throw Exception('Id de cliente no es válido');
    }
    return await _customerRepository.delete(customerId, customerStatus);
  }
}
