import 'package:flutter/foundation.dart';

import '../../data/models/stream_model.dart';
import '../../data/repositories/stream_repository.dart';

enum HomeTab { stream, hot, follow }

class RegionFilter {
  const RegionFilter({required this.code, required this.label, required this.flag});
  final String code;
  final String label;
  final String flag;
}

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({StreamRepository? repository})
      : _repository = repository ?? StreamRepository();

  final StreamRepository _repository;

  final List<RegionFilter> regions = const [
    RegionFilter(code: 'global', label: 'Global', flag: '🌐'),
    RegionFilter(code: 'in', label: 'India', flag: '🇮🇳'),
    RegionFilter(code: 'ph', label: 'Philippines', flag: '🇵🇭'),
    RegionFilter(code: 'br', label: 'Brazil', flag: '🇧🇷'),
    RegionFilter(code: 'vn', label: 'Vietnam', flag: '🇻🇳'),
    RegionFilter(code: 'tr', label: 'Turkey', flag: '🇹🇷'),
    RegionFilter(code: 'us', label: 'USA', flag: '🇺🇸'),
  ];

  HomeTab _activeTab = HomeTab.stream;
  int _activeRegionIndex = 0;
  int _bottomNavIndex = 0;
  bool _loading = false;
  List<StreamModel> _streams = const [];

  HomeTab get activeTab => _activeTab;
  int get activeRegionIndex => _activeRegionIndex;
  int get bottomNavIndex => _bottomNavIndex;
  bool get loading => _loading;
  List<StreamModel> get streams => _streams;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _streams =
        await _repository.fetchStreams(region: regions[_activeRegionIndex].code);
    _loading = false;
    notifyListeners();
  }

  void setTab(HomeTab tab) {
    if (_activeTab == tab) return;
    _activeTab = tab;
    notifyListeners();
  }

  void setRegion(int index) {
    if (_activeRegionIndex == index) return;
    _activeRegionIndex = index;
    notifyListeners();
    load();
  }

  void setBottomNav(int index) {
    if (_bottomNavIndex == index) return;
    _bottomNavIndex = index;
    notifyListeners();
  }

  void toggleFollow(String id) {
    _streams = [
      for (final s in _streams)
        if (s.id == id) s.copyWith(isFollowing: !s.isFollowing) else s,
    ];
    notifyListeners();
  }
}
