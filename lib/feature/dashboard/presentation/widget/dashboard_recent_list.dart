import 'package:flutter/material.dart';

class DashboardRecentList extends StatelessWidget {
  const DashboardRecentList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> demoContactsImage = [
      'https://i.postimg.cc/g25VYN7X/user-1.png',
      'https://i.postimg.cc/cCsYDjvj/user-2.png',
      'https://i.postimg.cc/sXC5W1s3/user-3.png',
      'https://i.postimg.cc/4dvVQZxV/user-4.png',
      'https://i.postimg.cc/FzDSwZcK/user-5.png',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent search",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(
                context,
              ).textTheme.titleSmall!.color!.withOpacity(0.32),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Stack(
              children: [
                ...List.generate(
                  demoContactsImage.length + 1,
                  (index) => Positioned(
                    left: index * 48,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: index < demoContactsImage.length
                          ? CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(
                                demoContactsImage[index],
                              ),
                            )
                          : const RoundedCounter(total: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedCounter extends StatelessWidget {
  final int total;

  const RoundedCounter({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2E2F45)
            : const Color(0xFFEBFAF3),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text("$total+", style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
