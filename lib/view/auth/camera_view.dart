import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/auth/auth_state.dart';
import 'package:whatsapp_clone/helpers/utils/show_error_dialog.dart';

import '../../controller/state/auth/auth_cubit.dart';

class CameraView extends StatefulWidget {
    const CameraView({super.key,
      required this.cameraDescription,
      });

    final CameraDescription cameraDescription;

    @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView>  with WidgetsBindingObserver {

  bool _isRearCam = true;




    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      final currentState = context.watch<AuthCubitState>() as AuthStateTakePicture;

      final CameraController camControl =  currentState.controller!;
      if(!camControl.value.isInitialized) return;
      if(state == AppLifecycleState.inactive) camControl.dispose();
      if(state == AppLifecycleState.resumed) camControl.resumePreview();
      super.didChangeAppLifecycleState(state);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return context.read<AuthCubit>().goBack();
      },
      child: BlocConsumer<AuthCubit, AuthCubitState>(
          builder: (context, state) {
            state as AuthStateTakePicture;
            return CameraPreview(
              state.controller,
              child: Scaffold(
                  body: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                             color: Colors.white,
                             padding: const EdgeInsets.only(bottom: 10),
                             onPressed: (){
                               context.read<AuthCubit>().pickImage();
                             },
                             icon: const Icon(Icons.photo)
                            ),
                          const SizedBox(width: 25,),
                          GestureDetector(
                            onTap: (){
                              context.read<AuthCubit>().takePicture(cameraController: state.controller);
                            },
                            child: Container(
                              height: 100,
                              width: 70,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          const SizedBox(width: 25,),
                          IconButton(
                             color: Colors.white,
                             padding: const EdgeInsets.only(bottom: 10),
                             onPressed: (){
                               setState(() {
                                 _isRearCam = !_isRearCam;
                               });
                               context.read<AuthCubit>().switchCameraOptions(
                                   isRearCam: _isRearCam,
                                   cameraController: state.controller,
                                   phone: state.phone
                               );
                             },
                             icon: const Icon(Icons.cameraswitch)
                            )
                        ],
                      ),


                    ],
                  )
              ),
            );
          },
          listener: (context, state) {
            if (state is AuthStateTakePicture){
              if(state.hasError == true) showErrorDialog(context, state.errorMessage!);
            }
          }
      ),
    );
  }
}