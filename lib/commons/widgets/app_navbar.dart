import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/config/theme/app_colors.dart';
import '../constants/string.dart';
import 'app_text.dart';

class AppNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final int roleId;

  const AppNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.roleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _navBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarItems() {
    List<BottomNavigationBarItem> items = [
      _buildNavItem(
        AppString.icHomeSolid,
        AppString.icHomeOutlined,
        "Beranda",
        0,
      ),
      _buildNavItem(
        AppString.icFilesSolid,
        AppString.icFilesOutlined,
        "Berkas",
        1,
      ),
      _buildNavItem(
        AppString.icSettingSolid,
        AppString.icSettingOutlined,
        "Pengaturan",
        roleId == 1 ? 3 : 2,
      ),
    ];

    if (roleId != 2 && roleId != 3) {
      items.insert(
        2,
        _buildNavItem(
          AppString.personOutline,
          AppString.personSolid,
          "Kelola Akun",
          2,
        ),
      );
    }

    return items;
  }

  BottomNavigationBarItem _buildNavItem(
      String iconActive, String iconInactive, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildIcon(iconActive, iconInactive, index, label),
      label: '',
    );
  }

  Widget _buildIcon(String active, String inactive, int index, String label) {
    bool isActive = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
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
                    active,
                    width: 20,
                    height: 20,
                  )
                : SvgPicture.asset(
                    inactive,
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
      ),
    );
  }
}
