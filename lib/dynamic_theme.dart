import 'package:flutter/material.dart';
import 'package:fyp/src/utils/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}): super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AppHome(),
    );

  }
}

class AppHome extends StatelessWidget{
  const AppHome({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("./fyp"), leading: const Icon(Icons.ondemand_video),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart), onPressed: () {},),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Heading",
              style: Theme.of(context).textTheme.headline2,),
            Text(
              "Sub_Heading",
              style: Theme.of(context).textTheme.subtitle2,),
            Text(
              "Paragraph",
              style: Theme.of(context).textTheme.bodyText1,),
            ElevatedButton(
              onPressed: () {}, child: const Text("Elevated Button"),),
            OutlinedButton(
              onPressed: () {}, child: const Text("Outlined Button"),),
            const Padding(padding: EdgeInsets.all(20.0),
              child: Image(image: AssetImage("assets/images/Back.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
