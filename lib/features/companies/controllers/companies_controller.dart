import 'package:flutter/foundation.dart';
import 'package:pulse/features/companies/models/company_model.dart';
import 'package:pulse/features/companies/services/company_repository.dart';

class CompaniesController extends ChangeNotifier {
  final CompanyRepository repository;
  static const int pageSize = 10;
  
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  List<Company> _companies = [];
  List<Company> _filteredCompanies = [];
  String _searchQuery = '';

  bool get isFetching => _isFetching;
  bool get hasMore => _hasMore;
  List<Company> get companies => _searchQuery.isEmpty ? _companies : _filteredCompanies;
  String get searchQuery => _searchQuery;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isEmpty => _companies.isEmpty && !_isFetching && _errorMessage == null;

  CompaniesController(this.repository);

  Future<void> fetchCompanies({bool refresh = false}) async {
    if (_isFetching) return;
    
    _isFetching = true;
    if (refresh) {
      _currentPage = 1;
      _companies = [];
      _hasMore = true;
      _errorMessage = null;
    }
    notifyListeners();

    try {
      final fetchedCompanies = await repository.fetchCompanies(page: _currentPage, pageSize: pageSize);
      if (refresh) {
        _companies = fetchedCompanies;
      } else {
        _companies.addAll(fetchedCompanies);
      }
      _hasMore = fetchedCompanies.length == pageSize;
      _currentPage++;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void loadMore() {
    if (_hasMore && !_isFetching) {
      fetchCompanies();
    }
  }

  void refresh() {
    fetchCompanies(refresh: true);
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredCompanies = [];
    } else {
      _filteredCompanies = _companies
          .where((company) =>
              company.name.toLowerCase().contains(_searchQuery) ||
              company.email.toLowerCase().contains(_searchQuery))
          .toList();
    }
    notifyListeners();
  }
}
