import 'package:click_to_copy/click_to_copy.dart';
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
    return SelectionArea(
      child: Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              DataTable(
                headingTextStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                headingRowColor: MaterialStateColor.resolveWith((states) => AppColor.primary),
                columns: [
                  const DataColumn(
                    label: Text("Sr. No."),
                  ),
                  const DataColumn(
                    label: Text("Name"),
                  ),
                  const DataColumn(
                    label: Text("Email"),
                  ),
                  DataColumn(
                    label: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.users.sort((a, b) => (a.phone ?? '').compareTo(b.phone ?? ""));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        label: const Text("Phone"),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.users
                              .sort((a, b) => (a.tokens ?? '').compareTo(b.tokens ?? ""));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        label: const Text("Remaining Tokens"),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.users.sort(
                            (a, b) => (a.timeagoe ?? '').compareTo(b.timeagoe ?? ""),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        label: const Text("Date Time"),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.users.sort(
                            (a, b) => (a.purchased ?? false)
                                .toString()
                                .compareTo((b.purchased ?? false).toString()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        label: const Text("Status"),
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text("Action"),
                  ),
                ],
                rows: List.generate(
                  20,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text(controller.users[index].username ?? '')),
                      DataCell(
                        Row(
                          children: [
                            Text(controller.users[index].useremail ?? ''),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () async {
                                await ClickToCopy.copy(controller.users[index].useremail!).then(
                                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copied!'),
                                    ),
                                  ),
                                );
                              },
                              child: controller.users[index].useremail != null &&
                                      controller.users[index].useremail!.isNotEmpty
                                  ? const Icon(Icons.copy_outlined, size: 16)
                                  : const SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Text("${controller.users[index].phone}"),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () async {
                                await ClickToCopy.copy(controller.users[index].phone!).then(
                                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copied!'),
                                    ),
                                  ),
                                );
                              },
                              child: controller.users[index].phone != null &&
                                      controller.users[index].phone!.isNotEmpty
                                  ? const Icon(Icons.copy_outlined, size: 16)
                                  : const SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                      DataCell(Text(controller.users[index].tokens ?? '0')),
                      DataCell(Text(controller.users[index].timeagoe ?? '')),
                      DataCell(
                        Container(
                          color: (controller.users[index].purchased ?? false)
                              ? Colors.green
                              : Colors.yellow,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            (controller.users[index].purchased ?? false) ? "Purchased" : "Pending",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            _showDialog(controller.users[index]);
                          },
                          child: const Text("UPDATE TOKEN"),
                        ),
                      ),
                    ],
                  ),
                ).toList(),
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(width: 80, child: Text('Sr. No', textAlign: TextAlign.start)),
              //       Expanded(child: Text('Name', textAlign: TextAlign.start)),
              //       Expanded(flex: 2, child: Text('Email', textAlign: TextAlign.start)),
              //       Expanded(flex: 2, child: Text('Phone', textAlign: TextAlign.center)),
              //       Expanded(child: Text('Remaining Tokens', textAlign: TextAlign.center)),
              //       Expanded(child: Text('Date Time', textAlign: TextAlign.center)),
              //       SizedBox(width: 20),
              //       Expanded(child: Text('Status', textAlign: TextAlign.center)),
              //       SizedBox(width: 20),
              //       Expanded(child: Text('Actions', textAlign: TextAlign.center)),
              //       SizedBox(width: 10),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 16),
              // Expanded(
              //   child: Obx(
              //     () => ListView.builder(
              //       shrinkWrap: true,
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //       itemCount: controller.users.length,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(6),
              //             color: index % 2 == 0 ? Colors.blue.withOpacity(.06) : null,
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               children: [
              //                 SizedBox(
              //                   width: 80,
              //                   child: Text(
              //                     "${index + 1}",
              //                     textAlign: TextAlign.start,
              //                     style: const TextStyle(color: AppColor.black),
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Text(
              //                     controller.users[index].username ?? '',
              //                     textAlign: TextAlign.start,
              //                     style: const TextStyle(color: AppColor.black),
              //                   ),
              //                 ),
              //                 Expanded(
              //                   flex: 2,
              //                   child: Row(
              //                     children: [
              //                       Expanded(
              //                         child: Text(
              //                           controller.users[index].useremail ?? '',
              //                           textAlign: TextAlign.start,
              //                           style: const TextStyle(color: AppColor.black),
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //                       ),
              //                       const SizedBox(width: 6),
              //                       InkWell(
              //                         onTap: () async {
              //                           await ClickToCopy.copy(controller.users[index].useremail!)
              //                               .then(
              //                             (value) => ScaffoldMessenger.of(context).showSnackBar(
              //                               const SnackBar(
              //                                 content: Text('Copied!'),
              //                               ),
              //                             ),
              //                           );
              //                         },
              //                         child: controller.users[index].useremail!.isNotEmpty
              //                             ? const Icon(Icons.copy_outlined, size: 16)
              //                             : const SizedBox.shrink(),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //                 const SizedBox(width: 6),
              //                 Expanded(
              //                   child: Row(
              //                     children: [
              //                       Expanded(
              //                         child: Text(
              //                           "${controller.users[index].phone}",
              //                           textAlign: TextAlign.center,
              //                           style: const TextStyle(color: AppColor.black),
              //                         ),
              //                       ),
              //                       const SizedBox(width: 6),
              //                       InkWell(
              //                         onTap: () async {
              //                           await ClickToCopy.copy(controller.users[index].phone!).then(
              //                             (value) => ScaffoldMessenger.of(context).showSnackBar(
              //                               const SnackBar(content: Text('Copied!')),
              //                             ),
              //                           );
              //                         },
              //                         child: controller.users[index].phone!.isNotEmpty
              //                             ? const Icon(Icons.copy_outlined, size: 16)
              //                             : const SizedBox.shrink(),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //                 const SizedBox(width: 10),
              //                 Expanded(
              //                   child: Text(
              //                     "${controller.users[index].tokens}",
              //                     textAlign: TextAlign.center,
              //                     style: const TextStyle(color: AppColor.black),
              //                   ),
              //                 ),
              //                 const SizedBox(width: 16),
              //                 Expanded(
              //                   child: Text(
              //                     "${controller.users[index].timeagoe}",
              //                     textAlign: TextAlign.center,
              //                     style: const TextStyle(color: AppColor.black),
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: controller.users[index].purchased == true
              //                       ? Container(
              //                           color: Colors.green,
              //                           margin: const EdgeInsets.symmetric(horizontal: 8),
              //                           padding: const EdgeInsets.all(10),
              //                           child: const Text(
              //                             "Purchased",
              //                             textAlign: TextAlign.center,
              //                             style: TextStyle(color: Colors.white),
              //                           ),
              //                         )
              //                       : const SizedBox.shrink(),
              //                 ),
              //                 Expanded(
              //                   child: AppButton(
              //                     text: "UPDATE TOKEN",
              //                     onPressed: () {
              //                       _showDialog(controller.users[index]);
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
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
