import 'package:flutter/cupertino.dart';
import 'package:material_app/Models/toolsModel.dart';

class ToolsProvider with ChangeNotifier {
  List<ToolsModel> toolsList = [
    ToolsModel(
      Tname: "Hammer",
      Tprice: 813,
      Timage: "assets/tools_icon/hammer.jpg",
      Tdescription:
          "The Hammer is an essential tool for various construction tasks...",
      Tapplications: [
        "Breaking hard ground",
        "rocks",
        "concrete",
        "excavation",
      ],
      Tspecifications: [
        "High-quality Steel",
        "1125 grams",
        "Standard",
      ],
    ),
    ToolsModel(
      Tname: "Pick Axe",
      Tprice: 1125,
      Timage: "assets/tools_icon/pick_axe.png",
      Tdescription:
          "The Pick Axe is a heavy-duty tool designed for breaking up hard ground, rocks, and concrete. Its sharp point and sturdy construction make it an essential tool for excavation and demolition tasks.",
      Tapplications: [
        "Breaking hard ground",
        "rocks",
        "concrete",
        "excavation",
      ],
      Tspecifications: [
        "High-quality Steel",
        "1125 grams",
        "Standard",
        "Sharp pick and flat end",
      ],
    ),
    ToolsModel(
      Tname: "Plastic Float",
      Tprice: 250,
      Timage: "assets/tools_icon/plastic_float.png",
      Tdescription:
          "The Plastic Float is a versatile tool used for finishing and smoothing wet concrete surfaces. Its lightweight and durable design make it easy to achieve a smooth and professional concrete finish.",
      Tapplications: [
        "Finishing",
        "smoothing",
        "wet",
        "concrete",
      ],
      Tspecifications: [
        "High-quality Plastic",
        "250 grams",
        "Standard",
        "Flat and textured surface",
      ],
    ),
    ToolsModel(
      Tname: "Plumb Bob",
      Tprice: 313,
      Timage: "assets/tools_icon/plumb_bob.png",
      Tdescription:
          "The Plumb Bob is a precision tool used to determine vertical alignment. Its weight and point allow it to hang straight down, ensuring accurate measurements and layouts.",
      Tapplications: [
        "Vertical",
        "alignment",
        "layout",
        "marking",
      ],
      Tspecifications: [
        "Metal",
        "313 grams",
        "Standard",
        "Weighted bob and pointed tip",
      ],
    ),
    ToolsModel(
      Tname: "Pruner",
      Tprice: 625,
      Timage: "assets/tools_icon/pruner.jpg",
      Tdescription:
          "The Pruner is a handheld cutting tool designed for trimming branches and shrubs. Its sharp blades and comfortable grip make it easy to achieve clean and precise cuts.",
      Tapplications: [
        "Trimming branches",
        "shrubs",
        "light pruning",
      ],
      Tspecifications: [
        "High-quality Steel and Plastic",
        "625 grams",
        "Standard",
        "Sharp cutting blades",
        "ergonomic handle",
      ],
    ),
    ToolsModel(
      Tname: "Rubber Hammer",
      Tprice: 563,
      Timage: "assets/tools_icon/rubber hammer.png",
      Tdescription:
          "The Rubber Hammer is a specialized tool used for tapping and aligning delicate materials without causing damage. Its rubber head provides a gentle impact while ensuring precise control.",
      Tapplications: [
        "Tapping",
        "delicate materials",
        "aligning",
      ],
      Tspecifications: [
        "Rubber and Wood",
        "563 grams",
        "Standard",
        "Rubber head",
        "wooden handle",
      ],
    ),
    ToolsModel(
      Tname: "Sickle",
      Tprice: 438,
      Timage: "assets/tools_icon/sickle.png",
      Tdescription:
          "The Sickle is a versatile cutting tool used for harvesting crops and clearing vegetation. Its curved blade and ergonomic handle allow for efficient and comfortable use.",
      Tapplications: [
        "Harvesting",
        "crops",
        "vegetation",
        "clearing",
      ],
      Tspecifications: [
        "High-quality Steel and Wood",
        "438 grams",
        "Standard",
        "Curved cutting blade",
        "comfortable grip",
      ],
    ),
    ToolsModel(
      Tname: "Spade",
      Tprice: 688,
      Timage: "assets/tools_icon/spade.jpg",
      Tdescription:
          "The Spade is a heavy-duty digging tool designed for excavating soil, transplanting plants, and other gardening tasks. Its sturdy construction and ergonomic handle make it a reliable choice for outdoor work.",
      Tapplications: [
        "Digging",
        "transplanting",
        "gardening",
      ],
      Tspecifications: [
        "High-quality Steel and Wood",
        "688 grams",
        "Standard",
        "Flat blade",
        "ergonomic handle",
      ],
    ),
    ToolsModel(
      Tname: "Sponge",
      Tprice: 188,
      Timage: "assets/tools_icon/sponde.png",
      Tdescription:
          "The Sponge is an essential tool for cleaning and finishing surfaces in construction and DIY projects. Its absorbent material and compact size make it convenient for various tasks.",
      Tapplications: [
        "Cleaning",
        "finishing",
        "wiping",
        "surfaces",
      ],
      Tspecifications: [
        "Absorbent Sponge",
        "188 grams",
        "Standard",
        "Soft and absorbent",
      ],
    ),
    ToolsModel(
      Tname: "Straight Edge",
      Tprice: 1623,
      Timage: "assets/tools_icon/straight_edge.jpg",
      Tdescription:
          "The Straight Edge is a precision measuring tool used to check the flatness and levelness of surfaces. Its accurate measurements and durable design ensure reliable results for construction and layout work.",
      Tapplications: [
        "Checking flatness",
        "levelness",
        "layout",
      ],
      Tspecifications: [
        "High-quality Metal",
        "1623 mm (64 inches)",
        "Precision measurement markings",
      ],
    ),
    ToolsModel(
      Tname: "Thread",
      Tprice: 94,
      Timage: "assets/tools_icon/thred.png",
      Tdescription:
          "The Thread is a versatile material used for various construction and sewing tasks. Its strong and flexible nature makes it suitable for binding, tying, and hanging objects.",
      Tapplications: [
        "Binding",
        "tying",
        "hanging",
        "objects",
      ],
      Tspecifications: [
        "Durable Fiber",
        "Standard",
        "Strong and flexible",
      ],
    ),
    ToolsModel(
      Tname: "Tinner's Hammer",
      Tprice: 375,
      Timage: "assets/tools_icon/timmer_hammer.png",
      Tdescription:
          "The Tinner's Hammer is a specialized tool used for sheet metal work and roofing projects. Its lightweight design and narrow head make it suitable for precise and controlled strikes.",
      Tapplications: [
        "Sheet",
        "metal work",
        "roofing",
      ],
      Tspecifications: [
        "High-quality Steel and Wood",
        "375 grams",
        "Standard",
        "Narrow head",
        "lightweight",
      ],
    ),
    ToolsModel(
      Tname: "Torpedo Level",
      Tprice: 863,
      Timage: "assets/tools_icon/torpedo_level.png",
      Tdescription:
          "The Torpedo Level is a compact and versatile tool used for checking horizontal and vertical alignment. Its vials and magnetic base ensure accurate measurements and hands-free operation.",
      Tapplications: [
        "Checking alignment",
        "leveling",
      ],
      Tspecifications: [
        "Durable Plastic and Metal",
        "863 mm (34 inches)",
        "Multiple vials",
        "magnetic base",
      ],
    ),
    ToolsModel(
      Tname: "Wheel Barrow",
      Tprice: 10625,
      Timage: "assets/tools_icon/wheel_borrow.png",
      Tdescription:
          "The Wheel Barrow is an indispensable tool for transporting heavy materials and construction debris. Its sturdy construction and large capacity make it a reliable choice for various construction tasks.",
      Tapplications: [
        "Transporting materials",
        "debris",
        "construction tasks",
      ],
      Tspecifications: [
        "Heavy-duty Metal and Rubber",
        "10625 cubic cm",
        "Large capacity, durable construction",
      ],
    ),
  ];
  List applications = [];
  List specifications = [];

  addApplications(TextEditingController controller){
    applications.add(controller.text);
    notifyListeners();
  }
  addSpecification(TextEditingController controller) {
    specifications.add(controller.text);
    notifyListeners();
  }
   removeApplications(int index){
    applications.removeAt(index);
    notifyListeners();
  }
  removeSpecification(int index){
    specifications.removeAt(index);
    notifyListeners();
  }
  
  addTools(String toolName, int toolPrice, String toolDescription,
      String toolImage, List toolApplications, List toolSpecification) {
    toolsList.add(
        ToolsModel(
        Tname: toolName,
        Tprice: toolPrice,
        Tdescription: toolDescription,
        Timage: toolImage,
        Tapplications: toolApplications,
        Tspecifications: toolSpecification));
    notifyListeners();
  }
}
