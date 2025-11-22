import 'package:flutter/material.dart';

class DashboardAllUserList extends StatelessWidget {
  const DashboardAllUserList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> demoContactsImage = [
      'https://i.postimg.cc/g25VYN7X/user-1.png',
      'https://i.postimg.cc/cCsYDjvj/user-2.png',
      'https://i.postimg.cc/sXC5W1s3/user-3.png',
      'https://i.postimg.cc/4dvVQZxV/user-4.png',
      'https://i.postimg.cc/FzDSwZcK/user-5.png',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Suggested",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(
                context,
              ).textTheme.titleSmall!.color!.withOpacity(0.32),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ...List.generate(
          demoContactsImage.length,
          (index) => ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0 / 2,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(demoContactsImage[index]),
            ),
            title: const Text("Jenny Wilson"),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
