import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/helpers/widgets/app/app_button.dart';

import '../../controller/state/auth/auth_cubit.dart';
import '../../controller/state/auth/auth_state.dart';
import '../../helpers/widgets/app/app_bar_widget.dart';
import '../../helpers/widgets/text/app_text_medium.dart';


class VerifyNumberView extends StatelessWidget {
  VerifyNumberView({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  //final tokenController = List.generate(6, (index) => TextEditingController());
  final controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBarWidget(title: 'Verify Number')),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:  TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                )
               ),
              const SizedBox(height: 10,),
              AppButton(
                  onTap: () {
                    final code = controller.text.trim();
                    context.read<AuthCubit>().verify(
                        phone: phoneNumber,
                        token: code
                    );
                  },
                  text: 'Verify'
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () async {
                    context.read<AuthCubit>().signIn(phone: phoneNumber);
                    },
                  child: const AppTextMedium(text: 'Resend Code'))
            ],
          ),
        );
      }
    );
  }
}
