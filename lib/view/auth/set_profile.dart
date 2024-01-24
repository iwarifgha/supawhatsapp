import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/helpers/widgets/app/app_button.dart';

import '../../controller/state/auth/auth_cubit.dart';
import '../../controller/state/auth/auth_state.dart';

class SetProfileView extends StatelessWidget {
  const SetProfileView({super.key,
    required this.phone,
   });
  final String phone;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return  WillPopScope(
      onWillPop: (){
        return context.read<AuthCubit>().startAuthFlow();
      },
      child: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          state as AuthStateSetProfile;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Set up your profile"),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      getImage(state.file),
                      Positioned(
                        bottom: -10,
                        left:  80,
                        child: IconButton(
                            onPressed: (){
                              context.read<AuthCubit>().openCamera(phone: state.phone);
                              },
                            icon: const Icon(Icons.photo_camera_rounded)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  AppButton(
                       onTap: (){
                         context.read<AuthCubit>().setProfile(
                             name: nameController.text,
                             avatarFile: state.file ?? File('assets/avatar.png'),
                             phone: phone
                         );
                       },
                       text: 'NEXT'
                   )
                ],
              ),
            );
        },
       ),
    );
  }
}

CircleAvatar getImage(File? displayImage){
  if(displayImage == null){
    return const CircleAvatar(
      radius: 65,
      backgroundImage: AssetImage('assets/avatar.png'),
    );
  } else {
    return CircleAvatar(
      radius: 65,
      backgroundImage: FileImage(displayImage),
    );
  }
}