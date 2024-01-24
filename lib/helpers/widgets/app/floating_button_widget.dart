
import 'package:flutter/material.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({Key? key,
    required this.notifier,
    required this.animation,
    required this.onShowContacts,
    required this.onAddStatus,
    required this.onStartCall,
   }) : super(key: key);

 final ValueNotifier<double> notifier;
 final Animation<double> animation;
 final VoidCallback onShowContacts;
 final VoidCallback onAddStatus;
  final VoidCallback onStartCall;





  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: notifier,
        builder: (_, currentIndex, __){
          if(!currentIndex.isNegative){
            return SizedBox(
              height: 400,
              child: Stack(
                alignment: Alignment.bottomRight,
                 children: [
                   ///add status button
                   AnimatedContainer(
                     height: 40,
                     width: 40,
                     duration: const Duration(milliseconds: 300),
                     transform: Matrix4.translationValues(-8, (currentIndex == 1 ? -70  : -0), 0),
                     curve: Curves.easeInOut,
                     alignment: Alignment.center,
                     child: FloatingActionButton.extended(
                       heroTag: null,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                       backgroundColor: Colors.blueGrey.withAlpha(150),
                       onPressed: onAddStatus,
                       label: const Icon(Icons.edit, size: 24, color: Colors.white,),
                       ),
                   ),

                   ///See contacts button
                   IgnorePointer(
                     ignoring: currentIndex != 0,
                     child: AnimatedOpacity(
                       opacity: currentIndex == 0 ? 1 :0 ,
                       duration: const Duration(milliseconds: 50),
                       child: SizedBox(
                        height: 55,
                        width: 55,
                        child: FloatingActionButton.extended(
                            heroTag: null,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                            elevation: 0,
                            onPressed: onShowContacts,
                            label: const Icon(Icons.message, size: 24,)),
                  ),
                     ),
                   ),
                   ///Second button
                   IgnorePointer(
                     ignoring: currentIndex != 1,
                     child: AnimatedOpacity(
                       opacity: currentIndex == 1 ? 1 : 0,
                       duration: const Duration(milliseconds: 50),
                       child: SizedBox(
                         height: 55,
                         width: 55,
                         child: FloatingActionButton.extended(
                           heroTag: null,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                           onPressed: () {
                             print('status');
                           },
                           label: const Icon(Icons.camera_alt_rounded, size: 24,),),
                       ),
                     ),
                   ),
                   ///Third button
                   IgnorePointer(
                     ignoring: currentIndex != 2,
                     child: AnimatedOpacity(
                       opacity: currentIndex == 2 ? 1 : 0,
                       duration: const Duration(milliseconds: 50),
                       child: SizedBox(
                         height: 55,
                         width: 55,
                         child: FloatingActionButton.extended(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                             heroTag: null,
                             onPressed: onStartCall,
                             label: const Icon(Icons.add_call)),
                       ),
                     ),
                   ),
                 ],
              ),
            );
          }
          else {
            return Container();
          }
        }
    );
  }
}
