import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/state/auth/auth_cubit.dart';
import '../../controller/state/auth/auth_state.dart';
import '../../helpers/widgets/app/app_bar_widget.dart';
import '../../helpers/widgets/app/app_button.dart';

//|| !value.number.contains(RegExp(r'^[0-9]+$'),1)


class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {


  final loginFormKey = GlobalKey<FormState>();
  String phoneNumber = '';
  TextEditingController passController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBarWidget(title: 'Sign in to Whatsapp')),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Form(
                      key: loginFormKey,
                      child: IntlPhoneField(
                        initialCountryCode: 'NG',
                        validator: (value){
                          if(value!.number.isEmpty || !value.isValidNumber()){
                            return 'Please input a valid number';
                          }
                          return null;
                        },
                        onChanged: (phone){
                          setState(() {
                            final number = phone.number.replaceFirst(RegExp(r'^[0-9]'), '');
                            final countryCode = phone.countryCode;
                            phoneNumber = countryCode + number;
                          });
                        } ,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //const SizedBox(height: 10),
                  AppButton(
                    onTap: () {
                      if (loginFormKey.currentState!.validate()) {
                        print(phoneNumber);
                      context.read<AuthCubit>().signIn(
                          phone: phoneNumber,
                      );
                        }
                      },
                    text: 'NEXT',
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}



