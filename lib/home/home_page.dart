import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text('Sr.no'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text('Name'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text('Email'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text('Phone'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text('Remin Token'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text('Actions'),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Colors.blue[50]),
                    // color: Color(0xff004D81),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
