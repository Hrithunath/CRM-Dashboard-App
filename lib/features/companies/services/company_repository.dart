import 'package:dio/dio.dart';
import 'package:pulse/features/companies/models/company_model.dart';

class CompanyRepository {
  final Dio dio;
  CompanyRepository(this.dio);

  Future<List<Company>> fetchCompanies({int page = 1, int pageSize = 10}) async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users');
    final data = response.data as List;
    // Simulate pagination on the mock API
    final start = (page - 1) * pageSize;
    final paged = data.skip(start).take(pageSize).toList();
    return paged.map((e) => Company.fromJson(e)).toList();
  }
}
