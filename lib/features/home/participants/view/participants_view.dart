import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_study_case/product/provider/providers.dart';
import 'package:voco_study_case/product/enum/project_enums.dart';
import '../../../../product/widget/network_image/custom_network_image.dart';
import '../model/user_model.dart';

class ParticipantsView extends ConsumerStatefulWidget {
  static const String routeName = "/participants-view";
  const ParticipantsView({super.key});

  @override
  ConsumerState<ParticipantsView> createState() => _ParticipantsViewState();
}

class _ParticipantsViewState extends ConsumerState<ParticipantsView>
    with ParticipantsViewMixin {
  @override
  Widget build(BuildContext context) {
    final participantsController =
        ref.watch(participantsControllerProvider.notifier);
    final participantsControlleRef = ref.watch(participantsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Participants"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: participantsController.users.length,
                itemBuilder: (context, index) => UserListTile(
                    userModel: participantsController.users[index]),
              ),
            ),
            participantsControlleRef == ProjectState.loading
                ? const CircularProgressIndicator()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
        title: Text(
          userModel.lastName,
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
          ),
        ),
        leading: CustomNetworkImage(
          imagePath: userModel.avatar,
          width: 50, 
          height: 50, 
        ),
      ),
    );
  }
}


mixin ParticipantsViewMixin on ConsumerState<ParticipantsView> {
  late ScrollController scrollController;
  int page = 1;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(participantsControllerProvider.notifier)
          .getUsers((page++).toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      ref
          .watch(participantsControllerProvider.notifier)
          .getUsers(page.toString());
    } else {}
  }
}
