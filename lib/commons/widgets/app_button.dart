import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final IconData? icon;
  final Color? iconColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.action,
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
    this.fontWeight,
    this.iconColor,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: isLoading ? null : action,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          side: BorderSide(color: borderColor ?? Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: iconColor ?? Colors.white,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        text: text,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        fontColor: fontColor ?? Colors.white,
                      ),
                    ],
                  )
                : AppText(
                    text: text,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    fontColor: fontColor ?? Colors.white,
                  ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback action;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  const ActionButton({
    super.key,
    required this.icon,
    required this.action,
    this.fontColor,
    this.backgroundColor = AppColors.primary,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}

class FileAddButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const FileAddButton({
    Key? key,
    this.text = "Tambah Data",
    required this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.10,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppDropdownButton extends StatefulWidget {
  final List<String> items;
  final String buttonText;
  final void Function(String) onSelected;

  const AppDropdownButton({
    Key? key,
    required this.items,
    required this.buttonText,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<AppDropdownButton> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlay(
        offset: offset,
        width: size.width,
        items: widget.items,
        onItemSelected: (item) {
          widget.onSelected(item);
          _removeDropdown();
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isDropdownOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _toggleDropdown,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: widget.buttonText,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            Icon(
              !_isDropdownOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownOverlay extends StatefulWidget {
  final Offset offset;
  final double width;
  final List<String> items;
  final void Function(String) onItemSelected;

  const _DropdownOverlay({
    required this.offset,
    required this.width,
    required this.items,
    required this.onItemSelected,
  });

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay>
    with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late AnimationController _sizeController;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _opacityController.forward();
    _sizeController.forward();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.offset.dx,
      top: widget.offset.dy + 48,
      width: widget.width,
      child: FadeTransition(
        opacity: _opacityController,
        child: SizeTransition(
          sizeFactor: _sizeController,
          axisAlignment: -1.0,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () => widget.onItemSelected(item),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: AppText(
                      text: item,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
