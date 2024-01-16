import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import '../../controller/state/home/home_cubit.dart';
import '../../controller/state/home/home_state.dart';
import '../../helpers/widgets/app/floating_button_widget.dart';
import '../../helpers/widgets/call/call_log_list.dart';
import '../../helpers/widgets/chat/chat_list.dart';
import '../../helpers/widgets/status/status_list.dart';
import '../status/write_status_view.dart';


class HomeView extends StatefulWidget  {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  ValueNotifier<double> notifier = ValueNotifier(0);
  late TabController tabController;




  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, );
     tabController.addListener(() {
        listener();
     });
     super.initState();
  }



  listener(){
    notifier.value = tabController.animation!.value;
  }

  @override
  void dispose() {
     tabController.dispose();
     super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: BlocConsumer<HomeCubit, HomeCubitState>(
          listener: (context, state){

          },
           builder: (context, state){
              state as HomePageState;
              if (state.chats != null){
                final chats = state.chats!;
                return NestedScrollView(
                    headerSliverBuilder: (context, _){
                      return [
                        SliverAppBar(
                          title: const Text('Whatsapp'),
                          elevation: 5,
                          //expandedHeight: 50,
                          primary: true,
                          floating: true,
                          snap: true,
                          pinned: true,
                          actions: const [
                            Icon(Icons.camera_alt_outlined,),
                            SizedBox(width: 20,),
                            Icon(Icons.search_outlined,),
                            SizedBox(width: 18,),
                            Icon(Icons.more_vert_outlined)
                          ],
                          bottom: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              controller: tabController,
                              tabs: const [
                                Tab(text: 'Chats',),
                                Tab(text: 'Status',),
                                Tab(text: 'Calls',)
                              ]),
                        )
                      ];
                    },
                    body: TabBarView(
                        controller: tabController,
                        children: [
                          //Chats Section
                          ChatList(
                            onTap: () {  },
                            chats: chats,
                          ),
                          //Status Section
                          const StatusList(),
                          //Call Log section
                          const CallLogList()
                        ]

                    ));
              }
              else {
                return const Center(
                    child: Text('No Chats to display!'));
              }
           }
       ),
        floatingActionButton: AppFloatingButton(
          notifier: notifier,
          animation: tabController.animation!,
          onStartChat: () {
            context.read<HomeCubit>().getContacts();
           },
          onAddStatus: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WriteStatusView()));
            },
          onStartCall: () {},
       ),
    );
  }
}

















