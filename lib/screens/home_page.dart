import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/config/routes.dart';
import 'package:bank_ifsc_flutter/utils/widget_utils.dart';
import 'package:bank_ifsc_flutter/utils/bank_data.dart';
import 'package:bank_ifsc_flutter/misc/images.dart';
import 'package:bank_ifsc_flutter/misc/strings.dart';
import 'package:bank_ifsc_flutter/widgets/w_fancy_auto_text_field.dart';
import 'package:bank_ifsc_flutter/widgets/w_fancy_text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController bankCityController;
  TextEditingController bankBranchController;
  TextEditingController bankIFSCController;
  FancyAutoCompleteTextField bankNameTextField;
  FancyAutoCompleteTextField bankStateTextField;

  @override
  void initState() {
    bankCityController = TextEditingController();
    bankBranchController = TextEditingController();
    bankIFSCController = TextEditingController();
    bankNameTextField = FancyAutoCompleteTextField(bankNameList, bankNameEditBoxHint, bankNameImage);
    bankStateTextField = FancyAutoCompleteTextField(Bank_state_list, bankStateEditBoxHint, bankStateImage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FancyTextField bankCityTextField = FancyTextField(bankCityController, bankCityEditBoxHint, bankCityImage);
    FancyTextField bankBranchTextField = FancyTextField(bankBranchController, bankBranchEditBoxHint, bankBranchImage);
    FancyTextField bankIFSCTextField = FancyTextField(bankIFSCController, bankIfscEditBoxHint, bankNameImage);

    return Scaffold(
        appBar: AppBar(
          title: Text(homePageTitle),
        ),
        drawer: _buildDrawerWidget(context),
        body: Builder(
          builder: (context) => Container(
                margin: EdgeInsets.all(12.0),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          bankNameTextField,
                          SizedBox(height: 12.0),
                          bankStateTextField,
                          SizedBox(height: 12.0),
                          bankCityTextField,
                          SizedBox(height: 12.0),
                          bankBranchTextField,
                          SizedBox(height: 12.0),
                          Text(OR),
                          SizedBox(height: 12.0),
                          bankIFSCTextField,
                          SizedBox(height: 12.0),
                          RaisedButton(
                            onPressed: () {
                              if (bankIFSCController.text.isNotEmpty) {
                                String route = "${Routes.bankDetails}?bankIFSC=${bankIFSCController.text}";
                                Application.router.navigateTo(context, route);
                              } else {
                                String bankName = bankNameTextField.textValue;
                                String bankState = bankStateTextField.textValue;
                                String bankCity = bankCityController.text;

                                if (bankName != null &&
                                    bankName.isNotEmpty &&
                                    bankState != null &&
                                    bankState.isNotEmpty &&
                                    bankCity != null &&
                                    bankCity.isNotEmpty) {
                                  String route =
                                      "${Routes.searchBank}?bankName=$bankName&bankState=$bankState&bankCity=$bankCity"
                                      "&bankBranch=${bankBranchController.text}";
                                  Application.router.navigateTo(context, route);
                                } else {
                                  WidgetUtils.showSnackBar(context, bankSearchRequiredField);
                                }
                              }
                            },
                            child: Text(
                              bankSearch,
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ));
  }

  Drawer _buildDrawerWidget(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(sliderImage),
          ),
          ListTile(
            leading: Image.asset(icATM, width: 28.0, height: 28.0),
            title: Text(drawerBalanceCheck),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.balanceCheck);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icCustomer, width: 28.0, height: 28.0),
            title: Text(drawerCustomerCare),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.customerCare);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icSearch, width: 28.0, height: 28.0),
            title: Text(drawerFindATM),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.findAtm);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icBranch, width: 28.0, height: 28.0),
            title: Text(drawerFindBranch),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.findBranch);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icCurrency, width: 28.0, height: 28.0),
            title: Text(drawerCurrencyConverter),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.currencyConverter);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icEMI, width: 28.0, height: 28.0),
            title: Text(drawerEMICalc),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.emi);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(icCompound, width: 28.0, height: 28.0),
            title: Text(drawerCompoundInt),
            onTap: () {
              Application.router.pop(context);
              Application.router.navigateTo(context, Routes.compoundInterest);
            },
            dense: true,
          )
        ],
      ),
    );
  }
}
