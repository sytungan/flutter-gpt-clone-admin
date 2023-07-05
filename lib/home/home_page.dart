import 'package:eurosom_admin/controller/firestore_controller.dart';
import 'package:eurosom_admin/home/widget/update_token_dialog.dart';
import 'package:eurosom_admin/model/user_model.dart';
import 'package:eurosom_admin/res/theme_color.dart';
import 'package:eurosom_admin/shimmers/app_shimmer.dart';
import 'package:eurosom_admin/utils/component/app_button.dart';
import 'package:eurosom_admin/utils/component/app_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(FirestoreController());

  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: AppShimmer(),
              )
            : Column(
                children: [
                  const SizedBox(height: 24),
                  SizedBox(
                    width: Get.width * .50,
                    child: Obx(
                      () => AppTextField(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                        ),
                        onChange: (value) {
                          controller.searchUser(value);
                        },
                        controller: controller.nameController.value,
                        cursorColor: AppColor.themeColor,
                        hintText: 'Search..',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColor.themeColor),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Expanded(child: buildBody()),
                ],
              ),
      ),
    );
  }

  _showDialog(UserModel user) {
    showDialog(
      barrierDismissible: true,
      context: context,
      useSafeArea: true,
      builder: (context) => UpdateTokenDialog(user: user),
    );
  }

  buildBody() {
    if (controller.users.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 80, child: Text('Sr. No', textAlign: TextAlign.start)),
                  Expanded(child: Text('Name', textAlign: TextAlign.start)),
                  Expanded(flex: 2, child: Text('Email', textAlign: TextAlign.start)),
                  SizedBox(width: 24),
                  Expanded(child: Text('Phone', textAlign: TextAlign.center)),
                  Expanded(child: Text('Remaining Tokens', textAlign: TextAlign.center)),
                  SizedBox(width: 24),
                  Expanded(child: Text('Actions', textAlign: TextAlign.center)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount:
                      controller.users.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: index % 2 == 0 ? Colors.blue.withOpacity(.06) : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "${index+1}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColor.black),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.users[index].username ?? '',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColor.black),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  controller.users[index].useremail ?? '',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColor.black),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Text(
                                  "${controller.users[index].phone}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: AppColor.black),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${controller.users[index].tokens}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: AppColor.black),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                  child: AppButton(
                                text: "UPDATE TOKEN",
                                onPressed: () {
                                  _showDialog(controller.users[index]);
                                },
                              )),
                              // Expanded(
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: AppColor.themeColor,
                              //       foregroundColor: AppColor.white,
                              //     ),
                              //     onPressed: () {
                              //       _showDialog(controller.users[index]);
                              //     },
                              //     child: const Text("UPDATE TOKEN"),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // color: Color(0xff004D81),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          "There is no users.",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
        ),
      );
    }
  }
}
