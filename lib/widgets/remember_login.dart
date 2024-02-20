import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

class RememberLogin extends StatelessWidget {
  const RememberLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(50),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: MSHCheckbox(
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: secondaryColor,
                ),
                style: MSHCheckboxStyle.fillScaleCheck,
                value: context.watch<LoginProvider>().isLoginSaved,
                onChanged: (selected) {
                  context.read<LoginProvider>().changeLoginSaved(selected);
                },
              ),
            ),
            const TableCell(
              child: Text(
                "Remember Login Info",
                style: TextStyle(color: accentColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
