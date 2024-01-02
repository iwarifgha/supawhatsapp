import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/state/auth/auth_cubit.dart';
import '../../controller/state/auth/auth_state.dart';
import '../../helpers/widgets/text/app_text_medium.dart';
import '../../helpers/widgets/text/app_text_small.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state){},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const AppTextMedium(
                  text: 'Welcome to SupaWhatsapp'),
              Container(
                height: 100,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/landing_img.png'))
                )
              ),
              const SizedBox(
                width: 50,
                  child: AppTextSmall(
                      text: 'Read our privacy policy. Tap "AGREE AND CONTINUE" to accept the Terms of Service')),
              ElevatedButton(
                  onPressed: (){},
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(0.0),
                    fixedSize: MaterialStatePropertyAll(Size(100, 35))
                  ),
                  child: const AppTextMedium(text: 'AGREE AND CONTINUE',)
              ),
            ]
          ),
        );
      }
    );
  }
}
