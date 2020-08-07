import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile_code_challenge_solution/core/constants/defaults.dart';
import 'package:mobile_code_challenge_solution/core/models/repository/repository.dart';
import 'package:mobile_code_challenge_solution/core/models/search_filter/search_filter.dart';
import 'package:mobile_code_challenge_solution/core/models/search_response/search_response.dart';
import 'package:mobile_code_challenge_solution/core/providers/get_repos/api.dart';

class RepositoryProvider with ChangeNotifier {
  final GetReposApi _api = GetReposApi();

  SearchResponse _searchResponse;
  UnmodifiableListView<Repository> get repositories =>
      UnmodifiableListView(_searchResponse.items);

  bool get isFinished => repositories.length >= _searchResponse.totalCount;

  int currentPage;

  SearchFilter defaultSearchFilter(int _currentPage) =>
      SearchFilter((SearchFilterBuilder b) => b
        ..numOfDaysAgo = numOfDaysAgoByDefault
        ..orderType = orderTypeByDefault
        ..requestedPage = _currentPage);

  Future<bool> getMoreRepositories() async {
    final searchFilter = defaultSearchFilter(currentPage);
    final apiResponse = await _api.getRepositories(searchFilter);
    if (apiResponse != null) {
      concatNewRepositories(apiResponse);
      currentPage++;
      return true;
    }
    return false;
  }

  SearchResponse concatNewRepositories(SearchResponse apiResponse) {
    return _searchResponse =
        _searchResponse.rebuild((b) => b..items.addAll(apiResponse.items));
  }

  Future<bool> getRepositories() async {
    currentPage = 0;
    final searchFilter = defaultSearchFilter(currentPage);
    final apiResponse = await _api.getRepositories(searchFilter);
    if (apiResponse != null) {
      _searchResponse = apiResponse;
      currentPage++;
      return true;
    }
    return false;
  }
}
