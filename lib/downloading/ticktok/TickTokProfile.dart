import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';

void main() async {
  final url = 'https://www.tiktok.com/@mahboobahmadmahbo62?lang=en';

  // Fetch the TikTok profile page
  final response = await http.get(Uri.parse(url), headers: {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
  });

  if (response.statusCode == 200) {
    // Parse the HTML content
    var document = htmlParser.parse(response.body);

    // Find the div with the class 'css-1uqux2o-DivItemContainerV2 e19c29qe17'
    List<Element> divElements = document.getElementsByClassName('css-1uqux2o-DivItemContainerV2 e19c29qe17');
    print("Div Content: ${divElements}");

    if (divElements.isNotEmpty) {
      // Print the content of each matched div
      divElements.forEach((element) {
        print("Div Content: ${element.text}");
      });
    } else {
      print('No div elements found with the specified class name.');
    }
  } else {
    print('Failed to load page: ${response.statusCode}');
  }
}
