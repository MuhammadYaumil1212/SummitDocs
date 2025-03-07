import 'package:SummitDocs/Presentations/dashboard/pages/dashboard_screen.dart';
import 'package:SummitDocs/Presentations/files/pages/files_screen.dart';
import 'package:SummitDocs/Presentations/settings/pages/settings_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../core/helper/message/message.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _bloc = HomeBloc();
  final PageController pageController = PageController();
  var _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _bloc.add(CheckNetwork());
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          AppString.logoApp,
          width: 45,
          height: 45,
        ),
        backgroundColor: AppColors.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColors.grayBackground,
            height: 4.0,
          ),
        ),
      ),

      /// listener used only for snackbar, dialog, navigation,etc
      listener: (BuildContext context, HomeState state) {
        if (state is NetworkUnavailable) {
          DisplayMessage.errorMessage(state.message, context);
        }
      },

      /// Use bloc builder if you wanna used the state
      appWidget: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              DashboardScreen(),
              const FilesScreen(),
              const SettingsScreen(),
            ],
          );
        },
      ),
      bottomAppbar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.5),
          backgroundColor: Colors.white,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: _buildNavItem(
                  AppString.icHomeSolid,
                  AppString.icHomeOutlined,
                  "Beranda",
                  0,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: _buildNavItem(
                  AppString.icFilesSolid,
                  AppString.icFilesOutlined,
                  "Berkas",
                  1,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: _buildNavItem(
                  AppString.icSettingSolid,
                  AppString.icSettingOutlined,
                  "Pengaturan",
                  2,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    String iconOutlined,
    String label,
    int index,
  ) {
    bool isActive = _selectedIndex == index;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      width: 100,
      decoration: BoxDecoration(
        color: !isActive ? Colors.transparent : AppColors.grayBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isActive
              ? SvgPicture.asset(
                  icon,
                  width: 20,
                  height: 20,
                )
              : SvgPicture.asset(
                  iconOutlined,
                  width: 20,
                  height: 20,
                ),
          const SizedBox(height: 4),
          AppText(
            text: label,
            fontColor: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
