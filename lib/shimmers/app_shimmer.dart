import 'package:eurosom_admin/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatefulWidget {
  const AppShimmer({Key? key}) : super(key: key);

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer> {
  final usersList = <UserModel>[];

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black12.withOpacity(0.3),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
