import 'package:flutter/material.dart';
import 'package:illuminare/illuminare.dart';

void main() async {
  await Illuminare.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void throwError() {
    throw Exception("This is a test exception");
  }

  void throwErrorNoMessage() {
    throw Exception();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example of Illuminare',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Test the Illuminare Logging Tool"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.verbose("Test verbose"),
                    child: const Text("Test verbose log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.debug("Test debug"),
                    child: const Text("Test debug log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => debugPrint("Test debug from debugPrint"),
                    child: const Text("Test debug from debugPrint"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info("Test info"),
                    child: const Text("Test info log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.warn("Test warning"),
                    child: const Text("Test warn log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.error("Test error"),
                    child: const Text("Test error log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.fatal("Test fatal"),
                    child: const Text("Test fatal log"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: throwError,
                    child: const Text("Test throw exception"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: throwErrorNoMessage,
                    child: const Text("Test throw exception no message"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Illuminare.instance.crash();
                    },
                    child: const Text("Test crash app"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Test logging of different types"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        Illuminare.info(["item 1", "item 2", "item 3"]),
                    child: const Text("Test log list"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(const Text("Text")),
                    child: const Text("Test log Text widget"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: ElevatedButton(
                        onPressed: () => Illuminare.debug("test"),
                        child: const Text("Test log Container widget"),
                      ),
                    )),
                    child: const Text("Test log Container widget"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(() => "function output"),
                    child: const Text("Test log function"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(TestClass()),
                    child: const Text("Test log class object"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(TestClass),
                    child: const Text("Test log class"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("More logging"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.info(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                    child: const Text("Test log long string"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.error("Log exception",
                        exception: Exception("Test exception")),
                    child: const Text("Test log exception"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Illuminare.error("Log information",
                        information: "Extra information"),
                    child: const Text("Test log information"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestClass {}
