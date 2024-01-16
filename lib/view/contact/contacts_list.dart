
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_cubit.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_state.dart';

import '../../controller/state/home/home_cubit.dart';
import '../../helpers/widgets/app/app_bar_widget.dart';
import '../../helpers/widgets/app/quick_action_tile.dart';
import '../../helpers/widgets/contact/contact_widget.dart';



class ContactsListView extends StatelessWidget {
    const ContactsListView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: (){
         return context.read<HomeCubit>().startApp();
       },
       child: BlocConsumer<ContactCubit, ContactCubitState>(
         listener: (context, state){
           if(state is ContactListState){
             //final value = context.watch<HomeCubit>().networkSubscription;
              //if(state.hasConnection == true) context.read<HomeCubit>().autoAddContacts();
           }
         },
         builder: (context, state) {
           state as ContactListState;
           return Scaffold(
               appBar: PreferredSize(
                 preferredSize: const Size.fromHeight(50),
                 child: AppBarWidget(
                   title: 'Select contact',
                   subtitle: state.contacts.length.toString(),
             )) ,
               body: CustomScrollView(
                   slivers: [
                     SliverList(
                         delegate: SliverChildBuilderDelegate(
                           childCount: 1,
                                 (context, index) => Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       QuickActionTile(title: 'New contact', onTap: () { },),
                                       const SizedBox(height: 20,),
                                       QuickActionTile(title: 'New group', onTap: () {  },),
                                       const SizedBox(height: 20,),
                                       const Padding(
                                         padding: EdgeInsets.all(8.0),
                                         child: Text('Contacts on Whatsapp'),
                                       ),
                                     ],
                                   ),
                                 )
                         )),
                     SliverList(
                         delegate: SliverChildBuilderDelegate(
                           childCount: 1,
                             (context, index) {
                             final contacts = state.contacts;
                               return ListView.builder(
                                   physics: const NeverScrollableScrollPhysics(),
                                   itemCount: contacts.length ,
                                   shrinkWrap: true,
                                   itemBuilder: (context, index){
                                     final contact = contacts[index];
                                     return  ContactWidget(
                                       imageUrl: 'assets/avatar.png' ,
                                       displayName: contact.name ?? contact.phoneNumber,
                                       onTap: () {
                                         context.read<ContactCubit>().getAUser(phone: contact.phoneNumber);
                                       },
                                     );
                                   }
                               );
                             }
                     )
                     ),

                   ],
                 )
           );
         }
       ),
     );
}}



