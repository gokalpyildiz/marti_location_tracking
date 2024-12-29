part of '../profile_view.dart';

class _ActivityItemCard extends StatelessWidget {
  const _ActivityItemCard({required this.activity, required this.index});
  final LocationStoreResponseModel activity;
  final int index;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    final date = activity.date?.toStringLocalDateFormat;
    final time = activity.date?.toHourMinuteString();
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            //todo translate
            label: 'Delete',
            foregroundColor: Colors.white,
            //borderRadius: BorderRadius.circular(6),
            backgroundColor: context.colorScheme.error,
            icon: Icons.delete_outline_outlined,
            onPressed: (_) async {
              cubit.remove(index);
            },
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.router.push(ActivityDetailRoute(activityIndex: index));
        },
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(13.0),
            child: Row(
              children: [
                if (activity.image != null) Image.memory(activity.image!, height: 90, width: 90, fit: BoxFit.fill),
                if (activity.image == null) Assets.images.mapLogo.image(height: 90, width: 90, fit: BoxFit.fill),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marker Count: ${activity.markers!.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Date: $date',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Hour: $time',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
