import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class SecuritySetting extends StatefulWidget {
  const SecuritySetting({super.key});

  @override
  State<SecuritySetting> createState() => _SecuritySettingState();
}

class _SecuritySettingState extends State<SecuritySetting> {
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Keamanan Aplikasi',
          style: TextStyle(
            // fontWeight: FontWeight.w500
          ),
        ),
        
        const SizedBox(height: AppDimen.marginPaddingSmall,),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
            border: Border.all(color: AppColor.lightPrimary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BiometricActivation(
                label: 'Biometrik untuk Login', 
                enabled: _biometricEnabled,
                isLoading: false,
                onTap: () {
                  setState(() {
                    _biometricEnabled = !_biometricEnabled;
                  });
                },
              ),
            ],
          )
        )
      ],
    );
  }
}

class BiometricActivation extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool enabled;
  final VoidCallback? onTap;

  const BiometricActivation({super.key, 
    required this.label, 
    required this.isLoading,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColor.lightGrey3,
                  ),
                ),
              ),
              const SizedBox(width: AppDimen.marginPaddingSmall,),
              Expanded(
                flex: 7,
                child:  Align(
                  alignment: Alignment.centerRight,
                  child: Switch(
                    value: enabled,
                    activeColor: AppColor.primary,
                    onChanged: (bool value) {
                    },
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}