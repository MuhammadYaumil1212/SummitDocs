import 'dart:typed_data';

import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../core/config/theme/app_colors.dart';

class AppTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;

  const AppTextfield({
    Key? key,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  @override
  _AppTextfieldState createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        validator: widget.validator,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hint,
          hintStyle: TextStyle(color: AppColors.grayBackground3),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class AppDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AppDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          hint: AppText(
            text: widget.label,
            fontColor: Colors.grey,
          ),
          value: selectedValue,
          items: widget.items
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
            });
            widget.onChanged(newValue);
          },
        ),
      ),
    );
  }
}

class AppDatePicker extends StatefulWidget {
  final TextEditingController dateController;
  final String hint;
  final bool readOnly;
  final Function(String value) value;

  AppDatePicker({
    required this.dateController,
    required this.hint,
    required this.value,
    this.readOnly = true,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? selectedDate;
  Future<void> _pickDate(BuildContext context) async {
    DateTime initialDate = selectedDate ?? DateTime.now();

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    currentDate: selectedDate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                    onDateChanged: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                ),
              ),
              AppButton(
                  text: "Pilih Tanggal",
                  action: () {
                    setState(() {
                      widget.dateController.text =
                          DateFormat('dd/MM/yyyy').format(selectedDate!);
                      widget.value(widget.dateController.text);
                    });
                    Navigator.pop(context);
                  })
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppTextfield(
      hint: widget.hint,
      controller: widget.dateController,
      onChanged: widget.value,
      readOnly: widget.readOnly,
      prefixIcon: Icon(Icons.date_range_outlined),
      onTap: () => _pickDate(context),
    );
  }
}

class AppUploadTextfield extends StatefulWidget {
  final String hint;
  final void Function(PlatformFile file) onFileSelected;

  const AppUploadTextfield({
    Key? key,
    required this.hint,
    required this.onFileSelected,
  }) : super(key: key);

  @override
  State<AppUploadTextfield> createState() => _AppUploadTextfieldState();
}

class _AppUploadTextfieldState extends State<AppUploadTextfield> {
  PlatformFile? _selectedFile;
  bool _isDeleting = false;

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
        _isDeleting = false;
      });
      widget.onFileSelected(_selectedFile!);
    }
  }

  void _deleteWithEffect() async {
    setState(() => _isDeleting = true);
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _selectedFile = null;
      _isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedFile != null && _selectedFile!.bytes != null) {
      return GestureDetector(
        onLongPress: _deleteWithEffect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 150,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  _isDeleting ? Colors.transparent : AppColors.grayBackground3,
              width: _isDeleting ? 3 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              _selectedFile!.bytes!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => _pickFile(context),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.upload_file_outlined),
              const SizedBox(width: 10),
              Expanded(
                  child: AppText(
                text: widget.hint,
                fontColor: AppColors.grayBackground3,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
