import 'package:eurosom_admin/controller/firestore_controller.dart';
import 'package:eurosom_admin/model/user_model.dart';
import 'package:eurosom_admin/res/theme_color.dart';
import 'package:eurosom_admin/utils/component/app_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateTokenDialog extends StatelessWidget {
  final UserModel user;

  UpdateTokenDialog({Key? key, required this.user}) : super(key: key);
  final controller = Get.find<FirestoreController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        children: [
          Row(
            children: [
              const Text(
                'Update Token',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.clear, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 20),
          const Text('Please choose the plan', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColor.themeColor,
                        value: '0',
                        title: const Text('Monthly'),
                        groupValue: controller.currentPlan.value,
                        onChanged: (value) {
                          controller.selectedTokens.value = "300";
                          controller.checkRadio(value.toString());
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColor.themeColor,
                        value: '1',
                        title: const Text('Yearly'),
                        groupValue: controller.currentPlan.value,
                        onChanged: (value) {
                          controller.selectedTokens.value = "3600";
                          controller.checkRadio(value.toString());
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColor.themeColor,
                        value: '2',
                        title: const Text('Other'),
                        groupValue: controller.currentPlan.value,
                        onChanged: (value) {
                          controller.selectedTokens.value = "0";
                          controller.checkRadio(value.toString());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (controller.currentPlan.value == '2')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AppTextField(
                      hintText: "Please enter tokens",
                      keyBoardType: TextInputType.number,
                      onChange: (v) {
                        controller.selectedTokens.value = v;
                      },
                    ),
                  )
                else
                  Text(controller.selectedTokens.value.toString()),
                const SizedBox(height: 16),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.selectedTokens.value.isNotEmpty) {
                Get.back();
                controller.updateTokenForUser(user);
              } else {}
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColor.themeColor,
              alignment: Alignment.center,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Update',
                style: TextStyle(color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
