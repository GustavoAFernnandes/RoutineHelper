import 'package:home_widget/home_widget.dart';
import 'package:project/domain-viewModel/use_cases/atualizarWidget.dart';

class AtualizarwidgetImp extends AtualizarWidget {

  @override
  void atualizarWidget(String labelText, String labelTitleDate) async {
    await HomeWidget.saveWidgetData('title_key', labelTitleDate.toString());
    await HomeWidget.saveWidgetData('message_key', labelText.toString());

    await HomeWidget.updateWidget(
      name: 'HomeWidgetProvider',
      androidName: 'HomeWidgetProvider',
    );
  }
}
