import 'package:flutter/material.dart';
import '../../provider/task_provider.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfflineModeInfoWidget extends StatelessWidget {
  const OfflineModeInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final reconnect = TaskProvider.of(context)?.refreshData;
    final color = TodoElementsColor.getTertiaryColor(context);
    final textStyle = AppTextStyles.regylarBodyText.copyWith(color: color);
    final iconColor = TodoElementsColor.getBlueColor(context);
    final widgetText = AppLocalizations.of(context)?.offline_mode_text ?? '';
    return Padding(
      padding: const EdgeInsets.only(
        left: 22.0,
        top: 0.0,
        bottom: 10.0,
        right: 14.2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Icon(
              Icons.wifi_off,
              color: color,
              size: 27.0,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Text(
            widgetText,
            style: textStyle,
          )),
          const SizedBox(width: 14),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: iconColor,
              size: 26,
            ),
            onPressed: reconnect,
          ),
        ],
      ),
    );
  }
}
