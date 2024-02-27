import 'package:eurosom_admin/controller/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/theme_color.dart';

class BulkUserUpdateDialog extends StatefulWidget {
  const BulkUserUpdateDialog({super.key});

  @override
  State<BulkUserUpdateDialog> createState() => _BulkUserUpdateDialogState();
}

class _BulkUserUpdateDialogState extends State<BulkUserUpdateDialog> {
  final controller = Get.find<FirestoreController>();

  @override
  void dispose() {
    controller.selectedUsers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bulk Enable/Disable Users",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey.shade50,
                    child: const Icon(
                      Icons.clear,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
              () => Flexible(
                child: ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) => Obx(
                    () => CheckboxListTile(
                      value: controller.selectedUsers.contains(
                        controller.users[index].id,
                      ),
                      onChanged: (v) {
                        if (controller.selectedUsers
                            .contains(controller.users[index].id)) {
                          controller.selectedUsers.remove(
                            controller.users[index].id,
                          );
                        } else {
                          controller.selectedUsers.add(
                            controller.users[index].id ?? '',
                          );
                        }
                        controller.update();
                      },
                      title: Row(
                        children: [
                          Text(
                            controller.users[index].username ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Token: ${controller.users[index].tokens ?? ''}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                      subtitle: Text(
                        "Email: ${controller.users[index].useremail}\t\t\t\tPhone: ${controller.users[index].phone}",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.disableAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.themeColor,
                    foregroundColor: AppColor.white,
                  ),
                  child: const Text("Disable Accounts"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
