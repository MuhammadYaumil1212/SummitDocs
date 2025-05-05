import 'package:SummitDocs/Presentations/admin_bank/pages/admin_bank.dart';
import 'package:SummitDocs/Presentations/dashboard_super_admin/pages/dashboard_screen.dart';
import 'package:SummitDocs/Presentations/error/error_screen.dart';
import 'package:SummitDocs/Presentations/files/pages/files_screen.dart';
import 'package:SummitDocs/Presentations/settings/pages/settings_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_navbar.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../core/helper/message/message.dart';
import '../../../core/helper/storage/AppStorage.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _bloc = HomeBloc();
  final PageController pageController = PageController();
  final AppStorage _storage = AppStorage.instance;
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
          if (state is NetworkUnavailable) {
            return ErrorScreen(
              imageString: AppString.errorImages,
              errorMessage: "Halaman Tidak Ditemukan",
            );
          }
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              DashboardScreen(),
              AdminBank(
                roleId: _storage.get<int>(AppString.ROLE) ?? 0,
              ),
              const SettingsScreen(),
            ],
          );
        },
      ),
      bottomAppbar: AppNavbar(
        roleId: _storage.get<int>(AppString.ROLE) ?? 0,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
