// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:biometric_signature/biometric_signature.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'dialog_update_profile.dart';

class SecuritySetting extends StatefulWidget {
  const SecuritySetting({super.key});

  @override
  State<SecuritySetting> createState() => _SecuritySettingState();
}

class _SecuritySettingState extends State<SecuritySetting> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

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
              Consumer<AuthModel>(
                builder: (context, model, child) {
                  return BiometricActivation(
                    label: 'Biometrik untuk Login', 
                    enabled: model.isBiometricActive,
                    isLoading: model.isCheckingBiometric,
                    onTap: () async {
                      final BiometricSignature biometricSignature = BiometricSignature();

                      // TODO:
                      // If biometric login active
                      if (model.isBiometricActive) {
                        await biometricSignature.deleteKeys();
                        model.toggleBiometric(false);
                  
                        return;
                      }
                  
                      final biometrics = await biometricSignature.biometricAuthAvailable();
                  
                      // If biometric is not available
                      if (biometrics!.contains('none, ')) {
                        String errorCode = biometrics.split(', ')[1];
                  
                        String dialogContentText = '';
                  
                        switch (errorCode) {
                          case 'BIOMETRIC_ERROR_HW_UNAVAILABLE':
                            dialogContentText = 'Maaf, perangkat Anda tidak mendukung fitur fingerprint saat ini.';
                            break;
                          case 'BIOMETRIC_ERROR_NO_HARDWARE':
                            dialogContentText = 'Perangkat Anda tidak memiliki hardware fingerprint.';
                            break;
                          case 'BIOMETRIC_ERROR_NONE_ENROLLED':
                            dialogContentText = 'Anda belum mendaftarkan data fingerprint. Silakan daftarkan data fingerprint Anda di pengaturan perangkat.';
                            break;
                          default:
                            dialogContentText = 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi nanti.';
                        }
                  
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColor.white,
                              title: Text('Biometrik Tidak Tersedia', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              content: Text(
                                dialogContentText,
                              ),
                            );
                          },
                        );
                        return;
                      }
                        
                      _showBiometricActivationConfirmationBottomSheet(
                        context,
                        onDismiss: () {
                          // setState(() {
                          //   _biometricEnabled = false;
                          // });
                        },
                        onConfirm: (ctx) async {
                          Navigator.pop(ctx);
                  
                          // Generate the pair key
                          final String? publicKey = await biometricSignature.createKeys();
                  
                          // Prompt fingerprint
                          final String? data = await biometricSignature.createSignature(
                            options: {
                              'payload': 'payload',
                              "promptMessage": "Mobile My E-Task"
                            },
                          ).onError((e, s) {
                            Fluttertoast.showToast(msg: (e as PlatformException).message ?? 'Gagal mengaktifkan biometrik. Silakan coba lagi.');
                            return null;
                          });

                          bool? passwordVerify;
                  
                          // If success, prompt user password
                          if (data != null) {
                            passwordVerify = await showDialog<bool>(
                              context: context, 
                              barrierDismissible: false,
                              builder: (ctx2) => DialogConfirmPassword(
                                formKey: _formKey,
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                isLoading: model.isLoading,
                                onSubmit: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // TODO:
                                    await model.verifyPassword('user', _passwordController.text);

                                    if (model.isPasswordVerified) {
                                      Navigator.pop(ctx2, true);
                                    }
                                  }
                                }
                              ),
                            );
                          } else {
                            await biometricSignature.deleteKeys();
                            return;
                          }
                  
                          // Enroll public key to the server
                          if (passwordVerify == true) {
                            await model.toggleBiometric(true, publicKey: publicKey!);
                          } else {
                            await biometricSignature.deleteKeys();
                            return;
                          }
                  
                          // Prompt success enrolling fingerprint
                          if (model.isSuccessEnrolling) {
                            // setState(() {
                            //   _biometricEnabled = true;
                            // });
                            Fluttertoast.showToast(msg: 'Login dengan fingerprint berhasil diaktifkan!');
                          } else {
                            Fluttertoast.showToast(msg: 'Terjadi kesalahan!');
                            await biometricSignature.deleteKeys();
                            return;
                          }
                        }
                      );
                    },
                  );
                }
              ),
            ],
          )
        )
      ],
    );
  }

  void _showBiometricActivationConfirmationBottomSheet(
    BuildContext context, 
    {
      required VoidCallback onDismiss,
      required Function(BuildContext) onConfirm,
    }
  ) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppDimen.radiusExtraLarge),  
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimen.marginPaddingSmall),
                child: Text(
                  'Aktifkan Biometrik untuk Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: AppDimen.marginPaddingSmall,),
              Container(
                padding: const EdgeInsets.all(AppDimen.marginPaddingSmall),
                child: Text(
                  'Biometrik fingerprint akan menggunakan data fingerprint yang Anda miliki di perangkat ini.\n\n'
                  'Pastikan anda telah mengatur fingerprint yang tepat dan anda setuju dengan pernyataan ini.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: AppDimen.marginPaddingSmall,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColor.lightPrimary)
                      ),
                      onPressed: () {
                        onDismiss();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Saya tidak setuju',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimen.marginPaddingSmall,),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColor.primary)
                      ),
                      onPressed: () {
                        onConfirm(context);
                      },
                      child: const Text(
                        'Ya, saya setuju',
                        style: TextStyle(
                          color: AppColor.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
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
                    onChanged: (bool value) => onTap!()
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