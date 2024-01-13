import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/state/auth/auth_cubit.dart';
import '../../controller/state/auth/auth_state.dart';
import '../../helpers/utils/loading_dialog.dart';
import '../../helpers/utils/show_error_dialog.dart';
import '../../helpers/widgets/app/app_bar_widget.dart';
import '../../helpers/widgets/app/app_button.dart';

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
    return BlocConsumer<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          if(state is AuthStateSignIn){
            if(state.isLoading == true) showLoading(context: context, text: 'Signing In');
            if(state.isLoading == false) Navigator.pop(context);
            if(state.hasError == true && state.errorMessage != null) showErrorDialog(context, state.errorMessage!);
          }
        } ,
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
                          if(value!.number.isEmpty || !value.number.contains(RegExp(r'^[0-9]+$'),1) || !value.isValidNumber()){
                            return 'Please input a valid number';
                          }
                          return null;
                        },
                        onChanged: (phone){
                          setState(() {
                            phoneNumber = phone.completeNumber;
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


/*Center(
                    child: TextField(
                      controller: passController,
                    ),
                  ),*/
// password: passController.text
