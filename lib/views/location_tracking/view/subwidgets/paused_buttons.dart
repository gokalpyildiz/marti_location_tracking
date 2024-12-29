part of '../location_tracking_view.dart';

class _PausedButtons extends StatelessWidget {
  const _PausedButtons();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LocationTrackingCubit>();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(20).copyWith(bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Expanded(
            child: MartiButton(
              onPressed: () async {
                await cubit.completeActivity();
                if (context.mounted) {
                  await InfoDialog.show(title: 'Konum takibi tamamlandı', context: context, onTapOk: null);
                }
              },
              height: 50,
              buttonType: MartiButtonType.error,
              title: 'BİTİR',
            ),
          ),
          RefreshButton(onPressed: () async {
            await cubit.resetDatas();
            if (context.mounted) {
              InfoDialog.show(title: 'Konum takibi yeniden başlatıldı', context: context, onTapOk: null);
            }
          }),
          Expanded(
            child: MartiButton(
              onPressed: () async {
                cubit.resumeActivity();
              },
              height: 50,
              buttonType: MartiButtonType.outlined,
              //todo translate
              title: 'Devam Et',
            ),
          ),
        ],
      ),
    );
  }
}
