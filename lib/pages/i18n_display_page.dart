import 'package:aiflutter/l10n/gen/app_localizations.dart';
import 'package:aiflutter/provider/locale_provider.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class I18nDisplayPage extends StatefulWidget {
  const I18nDisplayPage({super.key});

  @override
  State<I18nDisplayPage> createState() => _I18nDisplayPageState();
}

class _I18nDisplayPageState extends State<I18nDisplayPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    return WindowFrameWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text(localizations.f1),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: true,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.validate();
              },
              child: Text('Validate'),
            ),
            ElevatedButton(
              onPressed: () {
                getPhoneNumber('+15417543010');
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.save();
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                // 通过 Provider.of 获取 LocaleProvider 实例并调用方法
                context.read<LocaleProvider>().setLocale(const Locale('zh'));
              },
              child: const Text("切换到中文"),
            ),
            ElevatedButton(
              onPressed: () {
                // 通过 Provider.of 获取 LocaleProvider 实例并调用方法
                context.read<LocaleProvider>().setLocale(const Locale('en'));
              },
              child: const Text("切换到英文"),
            ),
          ],
        ),
      ),
    ));
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
