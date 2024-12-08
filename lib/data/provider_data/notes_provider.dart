import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class NotesProvider {
  Future getApiData() async {
    try {
      var response = await http
          .get(Uri.parse("https://notes-backend-wj58.onrender.com/notes"));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
            "Failed to load product: Status code ${response.statusCode}");
      }
    } on SocketException {
      throw "SocKetException";
    } catch (e) {
      throw Exception("Some error Occurred ${e.toString()}");
    }
  }
}























// List shopeByCategory = [
//   {
//     "title": "Notebook",
//     "image":
//         "https://images.unsplash.com/photo-1726121678240-9126d5017990?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D",
//     // "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSTvIniUGvAUhRllXuATrykjs-I35XE7sghKf4FPyjlPH7OS3alayIx8EK7y5zf35Lot15YNP7-b7kW6jXuTEPLjT7LiuhVQAnAPuVRM3s&usqp=CAE",
//     "discount": "Up to 20% off"
//   },
//   {
//     "title": "Pen",
//     "image":
//         "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTwg6ov0X-iQIe05hyRJPPpZ-K-gFFvQWnCx8nDxZySGjpRudI2StLUJye8_TcVT-PN1L65dQ1gOGDjDP89Rsu0WM4caHqmh7wFTTa4QsLDMCCdy2Pz7k3D9VvaHK2-wu06GRhY-DTZjQ&usqp=CAc",
//     "discount": "Up to 25% off"
//   },
//   {
//     "title": "Bag",
//     "image":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiPBpCtlv-yfOXjocyYKWXzktX5TMEJAe0MA&s",
//     "discount": "Up to 15% off"
//   },
//   {
//     "title": "Notebook",
//     "image":
//         "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSTvIniUGvAUhRllXuATrykjs-I35XE7sghKf4FPyjlPH7OS3alayIx8EK7y5zf35Lot15YNP7-b7kW6jXuTEPLjT7LiuhVQAnAPuVRM3s&usqp=CAE",
//     "discount": "Up to 20% off"
//   },
//   {
//     "title": "Pen",
//     "image":
//         "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTwg6ov0X-iQIe05hyRJPPpZ-K-gFFvQWnCx8nDxZySGjpRudI2StLUJye8_TcVT-PN1L65dQ1gOGDjDP89Rsu0WM4caHqmh7wFTTa4QsLDMCCdy2Pz7k3D9VvaHK2-wu06GRhY-DTZjQ&usqp=CAc",
//     "discount": "Up to 25% off"
//   },
//   {
//     "title": "Bag",
//     "image":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiPBpCtlv-yfOXjocyYKWXzktX5TMEJAe0MA&s",
//     "discount": "Up to 15% off"
//   },
// ];
