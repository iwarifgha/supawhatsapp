import 'package:flutter/material.dart';

class AlertOverlay {

  OverlayEntry? overlayEntry;

  OverlayEntry _showLoadingOverlay(BuildContext context, {
    required String text
  }){
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlay;

    overlay = OverlayEntry(
        builder: (context){
          return Material(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10,),
                      Text(text)
                    ],
                  ),
                ),
              ),
            );
        });

    overlayState.insert(overlay);
    return overlay;
  }

  OverlayEntry _showErrorOverlay(BuildContext context, {
    required String text
  }){
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlay;

    overlay = OverlayEntry(
        builder: (context){
          return Material(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Error'),
                    const SizedBox(height: 10,),
                    Text(text),
                    TextButton(
                        onPressed: (){
                          overlay?.remove();
                        },
                        child: const Text('Ok'))

                  ],
                ),
              ),
            ),
          );
        });

    overlayState.insert(overlay);
    return overlay;
  }


  void showLoading({
    required String text,
    required BuildContext context
  }){
    overlayEntry = _showLoadingOverlay(context, text: text);
  }

  void showError({
    required String text,
    required BuildContext context
  }){
    overlayEntry = _showErrorOverlay(context, text: text);
  }

  void dismiss(){
    print('dismiss');
    overlayEntry?.remove();
    overlayEntry = null;
  }


}