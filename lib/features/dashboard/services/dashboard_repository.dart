import 'package:dio/dio.dart';
import 'package:pulse/features/companies/models/company_model.dart';

class DashboardRepository {
  final Dio dio;
  DashboardRepository(this.dio);

  Future<DashboardData> fetchDashboardData() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users');
    final List data = response.data;
    final companies = data.map((e) => Company.fromJson(e)).toList();
    // Generate mock fields
    final totalCompanies = companies.length;
    final totalRevenue = companies.fold<double>(0, (sum, c) => sum + c.mockRevenue);
    final totalActivities = companies.fold<double>(0, (sum, c) => sum + c.mockActivities);
    final totalMeetings = companies.fold<double>(0, (sum, c) => sum + c.mockMeetings);
    return DashboardData(
      totalCompanies: totalCompanies,
      totalRevenue: totalRevenue,
      totalActivities: totalActivities.toInt(),
      totalMeetings: totalMeetings.toInt(),
      companies: companies,
    );
  }
}

class DashboardData {
  final int totalCompanies;
  final double totalRevenue;
  final int totalActivities;
  final int totalMeetings;
  final List<Company> companies;
  DashboardData({
    required this.totalCompanies,
    required this.totalRevenue,
    required this.totalActivities,
    required this.totalMeetings,
    required this.companies,
  });
}
