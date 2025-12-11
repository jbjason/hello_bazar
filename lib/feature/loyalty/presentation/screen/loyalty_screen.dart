// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDimens().getNormalAppBar("Loyalty", [
          IconButton(
            icon: Icon(Icons.add, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const AddDuePage()),
              // );
            },
          ),
          SizedBox(width: 8.w),
        ], context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Banner
                _buildWelcomeBanner(context),

                const SizedBox(height: 24),

                // Statistics Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Statistics',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      _buildStatisticsGrid(context),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Recent Transactions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      _buildTransactionList(context),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyColor.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your loyalty points are growing fast!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: MyColor.white, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '2,450 Points',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: MyColor.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: MyColor.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium,
              color: MyColor.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(BuildContext context) {
    final statistics = [
      {
        'title': 'Total Sales',
        'value': '৳12,450',
        'icon': Icons.shopping_cart_outlined,
        'color': MyColor.primary,
        'trend': '+12.5%',
        'trendColor': MyColor.success,
      },
      {
        'title': 'Loyalty Points',
        'value': '2,450',
        'icon': Icons.star_outline,
        'color': MyColor.warning,
        'trend': '+8.2%',
        'trendColor': MyColor.success,
      },
      {
        'title': 'New Members',
        'value': '42',
        'icon': Icons.person_add_outlined,
        'color': MyColor.success,
        'trend': '+15.3%',
        'trendColor': MyColor.success,
      },
      {
        'title': 'Avg. Order',
        'value': '৳1,240',
        'icon': Icons.trending_up_outlined,
        'color': MyColor.error,
        'trend': '-3.2%',
        'trendColor': MyColor.error,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: statistics.length,
      itemBuilder: (context, index) {
        final stat = statistics[index];
        return _buildStatCard(context, stat);
      },
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stat['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(stat['icon'], color: stat['color'], size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: stat['trendColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  stat['trend'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: stat['trendColor'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stat['value'],
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            stat['title'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    final transactions = [
      {
        'customer': 'John Doe',
        'points': '+150',
        'amount': '৳2,450',
        'time': '10:30 AM',
        'type': 'earned',
      },
      {
        'customer': 'Jane Smith',
        'points': '-75',
        'amount': '৳1,200',
        'time': '11:15 AM',
        'type': 'redeemed',
      },
      {
        'customer': 'Mike Johnson',
        'points': '+200',
        'amount': '৳3,000',
        'time': '01:45 PM',
        'type': 'earned',
      },
      {
        'customer': 'Sarah Wilson',
        'points': '+120',
        'amount': '৳1,800',
        'time': '03:20 PM',
        'type': 'earned',
      },
      {
        'customer': 'Alex Brown',
        'points': '-50',
        'amount': '৳850',
        'time': '04:10 PM',
        'type': 'redeemed',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Theme.of(context).dividerTheme.color),
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _buildTransactionItem(context, transaction);
        },
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    final isEarned = transaction['type'] == 'earned';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isEarned
              ? MyColor.success.withOpacity(0.1)
              : MyColor.error.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isEarned ? Icons.add : Icons.remove,
          color: isEarned ? MyColor.success : MyColor.error,
          size: 20,
        ),
      ),
      title: Text(
        transaction['customer'],
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        transaction['time'],
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            transaction['points'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isEarned ? MyColor.success : MyColor.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            transaction['amount'],
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// Add this to your main app or navigation
// Example usage:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const LoyaltyScreen()));

// class LoyaltyScreen extends StatelessWidget {
//   const LoyaltyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         LoyaltyAppbar(),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(12.h),
//             child: Column(
//               children: [
//                 LoyaltyRecentList(),
//                 SizedBox(height: 16.0),
//                 LoyaltyAllUserList(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
