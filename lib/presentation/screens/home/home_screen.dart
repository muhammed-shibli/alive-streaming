import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../chats/chats_screen.dart';
import '../party/party_screen.dart';
import '../profile/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/category_tabs.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/region_chips.dart';
import 'widgets/stream_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.primaryGreen,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: _bodyFor(vm),
        ),
        bottomNavigationBar: HomeBottomNavBar(
          activeIndex: vm.bottomNavIndex,
          onChanged: vm.setBottomNav,
        ),
      ),
    );
  }

  Widget _bodyFor(HomeViewModel vm) {
    switch (vm.bottomNavIndex) {
      case 1:
        return const PartyScreen();
      case 3:
        return const ChatsScreen();
      case 4:
        return const ProfileScreen();
      default:
        return _StreamFeed(vm: vm);
    }
  }
}

class _StreamFeed extends StatelessWidget {
  const _StreamFeed({required this.vm});
  final HomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppBar(),
        CategoryTabs(active: vm.activeTab, onChanged: vm.setTab),
        const SizedBox(height: 16),
        RegionChips(
          regions: vm.regions,
          activeIndex: vm.activeRegionIndex,
          onChanged: vm.setRegion,
        ),
        const SizedBox(height: 14),
        Expanded(
          child: vm.loading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: vm.load,
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: vm.streams.length,
                    itemBuilder: (_, i) {
                      final s = vm.streams[i];
                      return StreamCard(
                        stream: s,
                        onTap: () {},
                        onFollowTap: () => vm.toggleFollow(s.id),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
