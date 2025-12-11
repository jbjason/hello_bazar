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
            icon: Icon(Icons.add, size: 20.w),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ], context),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 24.h,
                children: [
                  // Welcome Banner
                  _buildWelcomeBanner(context),
                  // Statistics Cards
                  _buildStatisticsGrid(context),
                  // Recent Transactions
                  _buildTransactionList(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.2),
            blurRadius: 20.w,
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Welcome Back! 👋',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: MyColor.onPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Your loyalty points are growing fast!',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: MyColor.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: MyColor.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.workspace_premium,
                        color: MyColor.white,
                        size: 40.w,
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: 16.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: MyColor.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: MyColor.white, size: 18.w),
                            SizedBox(width: 8.w),
                            Text(
                              '2,450 Points',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: MyColor.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: MyColor.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: MyColor.white,
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '+12% Today',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: MyColor.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
        'value': '৳ 12,450',
        'icon': Icons.shopping_cart_outlined,
        'color': MyColor.primary,
        'trend': '+12.5%',
        'trendColor': MyColor.success,
        'subtitle': 'Today\'s revenue',
      },
      {
        'title': 'Loyalty Points',
        'value': '2,450',
        'icon': Icons.star_outline,
        'color': MyColor.warning,
        'trend': '+8.2%',
        'trendColor': MyColor.success,
        'subtitle': 'Active points',
      },
      {
        'title': 'New Members',
        'value': '42',
        'icon': Icons.person_add_outlined,
        'color': MyColor.success,
        'trend': '+15.3%',
        'trendColor': MyColor.success,
        'subtitle': 'This month',
      },
      {
        'title': 'Avg. Order',
        'value': '৳ 1,240',
        'icon': Icons.trending_up_outlined,
        'color': MyColor.error,
        'trend': '-3.2%',
        'trendColor': MyColor.error,
        'subtitle': 'Per customer',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Statistics',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.2,
          ),
          itemCount: statistics.length,
          itemBuilder: (context, index) {
            final stat = statistics[index];
            return _buildStatCard(context, stat);
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: MyDimens.getBoxDecoration,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: stat['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(stat['icon'], color: stat['color'], size: 20.w),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: stat['trendColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    stat['trend'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: stat['trendColor'],
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              stat['value'],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            Text(
              stat['title'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              stat['subtitle'],
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    final transactions = [
      {
        'customer': 'John Doe',
        'points': '+150',
        'amount': '৳ 2,450',
        'time': '10:30 AM',
        'type': 'earned',
        'icon': Icons.shopping_bag_outlined,
      },
      {
        'customer': 'Jane Smith',
        'points': '-75',
        'amount': '৳ 1,200',
        'time': '11:15 AM',
        'type': 'redeemed',
        'icon': Icons.card_giftcard_outlined,
      },
      {
        'customer': 'Mike Johnson',
        'points': '+200',
        'amount': '৳ 3,000',
        'time': '01:45 PM',
        'type': 'earned',
        'icon': Icons.local_offer_outlined,
      },
      {
        'customer': 'Sarah Wilson',
        'points': '+120',
        'amount': '৳ 1,800',
        'time': '03:20 PM',
        'type': 'earned',
        'icon': Icons.restaurant_outlined,
      },
      {
        'customer': 'Alex Brown',
        'points': '-50',
        'amount': '৳ 850',
        'time': '04:10 PM',
        'type': 'redeemed',
        'icon': Icons.coffee_outlined,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: MyColor.primary),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              color: Theme.of(context).dividerTheme.color,
              indent: 16.w,
              endIndent: 16.w,
            ),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return _buildTransactionItem(context, transaction);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    final isEarned = transaction['type'] == 'earned';

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isEarned
              ? MyColor.success.withOpacity(0.1)
              : MyColor.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          transaction['icon'],
          color: isEarned ? MyColor.success : MyColor.error,
          size: 20.w,
        ),
      ),
      title: Text(
        transaction['customer'],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
      subtitle: Text(
        transaction['time'],
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
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
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            transaction['amount'],
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
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
