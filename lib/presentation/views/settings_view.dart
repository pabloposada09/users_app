import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/presentation/providers/theme_provider.dart';
import 'package:users_app/presentation/widgets/pop_up/dialogs.dart';
import 'package:users_app/utils/constants/constants.dart';
import 'package:users_app/utils/constants/screen_measures.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  void handleSaveTap(BuildContext context, WidgetRef ref) {
    EasyLoading.show(status: Constants.loading);
    ref.read(themeProvider.notifier).saveConfiguration().then((status) {
      EasyLoading.dismiss();
      Dialogs.showSnackBar(context, status ? Constants.configurationSaved : Constants.error);
    });
  }

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeProvider);

    final colorOptions = ref.watch(colorsProvider);

    return SafeArea(
      child: Column(
        children: [
          SwitchListTile(
            subtitle: const Text(Constants.darkModeDescription),
            title: const Text(Constants.darkMode),
            value: theme.isDaskMode,
            onChanged: ref.read(themeProvider.notifier).toggleDarkMode,
          ),
          ExpansionTile(
            title: const Text(Constants.applicationColor),
            children: [
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: colorOptions.length,
                  itemBuilder: (context, index) {
                    final color = colorOptions[index];

                    return RadioListTile(
                      value: index,
                      groupValue: theme.selectedColor,
                      onChanged: ref.read(themeProvider.notifier).changeColor,
                      activeColor: color,
                      title: Text(
                        'Color : ${color.value}',
                        style: TextStyle(fontWeight: FontWeight.normal, color: color),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: ScreenMeasures.spaceBetweenElements,
          ),
          FilledButton.tonalIcon(
            onPressed: () => handleSaveTap(context, ref),
            icon: const Icon(Icons.save),
            label: const Text(Constants.saveConfiguration),
          )
        ],
      ),
    );
  }
}
