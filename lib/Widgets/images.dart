import 'package:lottie/lottie.dart';

var loading = Lottie.asset("assets/icons/loading.json", width: 30);

var tools = "assets/icons/tools.png";
var services = "assets/icons/services.png";
var material = "assets/material_icon/material.png";

//Material Icons List
var blocks = "assets/material_icon/barring.png";
var bricks = "assets/material_icon/bricks.png";
var tiles = "assets/material_icon/tiles.png";
var cement = "assets/material_icon/cement.png";
var gravel = "assets/material_icon/gravel.png";
var sand = "assets/material_icon/sand.png";
var soil = "assets/material_icon/sand.png";
var garder = "assets/material_icon/garder.png";
var sariya = "assets/material_icon/barring.png";

List materils_list = [
  ["Blocks (بلاک)", blocks],
  ["Bricks (اینٹ)", bricks],
  ["Tiles (ٹائلیں)", tiles],
  ["Cement (سیمنٹ)", cement],
  ["Gravel (بجری)", gravel],
  ["Sand (ریت)", sand],
  ["Soil (مٹی)", soil],
  ["Girder", garder],
  ["Barring (سریا)", sariya]
];
List tools_list = [

  ["Pick Axe",
    "assets/tools_icon/pick_axe.png",
    1125,
    "The Pick Axe is a heavy-duty tool designed for breaking up hard ground, rocks, and concrete. Its sharp point and sturdy construction make it an essential tool for excavation and demolition tasks.",
    {
      "Type": "Pick Axe",
      "Material": "High-quality Steel",
      "Weight": "1125 grams",
      "Length": "Standard",
      "Features": "Sharp pick and flat end",
      "Application": "Breaking hard ground, rocks, concrete, excavation"
    }
  ],

  ["Plastic Float",
    "assets/tools_icon/plastic_float.png",
    250,
    "The Plastic Float is a versatile tool used for finishing and smoothing wet concrete surfaces. Its lightweight and durable design make it easy to achieve a smooth and professional concrete finish.",
    {
      "Type": "Plastic Float",
      "Material": "High-quality Plastic",
      "Weight": "250 grams",
      "Length": "Standard",
      "Features": "Flat and textured surface",
      "Application": "Finishing and smoothing wet concrete"
    }
  ],

  ["Plumb Bob",
    "assets/tools_icon/plumb_bob.png",
    313,
    "The Plumb Bob is a precision tool used to determine vertical alignment. Its weight and point allow it to hang straight down, ensuring accurate measurements and layouts.",
    {
      "Type": "Plumb Bob",
      "Material": "Metal",
      "Weight": "313 grams",
      "Length": "Standard",
      "Features": "Weighted bob and pointed tip",
      "Application": "Vertical alignment, layout marking"
    }
  ],

  ["Pruner",
    "assets/tools_icon/pruner.jpg",
    625,
    "The Pruner is a handheld cutting tool designed for trimming branches and shrubs. Its sharp blades and comfortable grip make it easy to achieve clean and precise cuts.",
    {
      "Type": "Pruner",
      "Material": "High-quality Steel and Plastic",
      "Weight": "625 grams",
      "Length": "Standard",
      "Features": "Sharp cutting blades, ergonomic handle",
      "Application": "Trimming branches, shrubs, light pruning"
    }
  ],

  ["Rubber Hammer",
    "assets/tools_icon/rubber hammer.png",
    563,
    "The Rubber Hammer is a specialized tool used for tapping and aligning delicate materials without causing damage. Its rubber head provides a gentle impact while ensuring precise control.",
    {
      "Type": "Rubber Hammer",
      "Material": "Rubber and Wood",
      "Weight": "563 grams",
      "Length": "Standard",
      "Features": "Rubber head, wooden handle",
      "Application": "Tapping delicate materials, aligning"
    }
  ],

  ["Sickle",
    "assets/tools_icon/sickle.png",
    438,
    "The Sickle is a versatile cutting tool used for harvesting crops and clearing vegetation. Its curved blade and ergonomic handle allow for efficient and comfortable use.",
    {
      "Type": "Sickle",
      "Material": "High-quality Steel and Wood",
      "Weight": "438 grams",
      "Length": "Standard",
      "Features": "Curved cutting blade, comfortable grip",
      "Application": "Harvesting crops, vegetation clearing"
    }
  ],

  ["Spade",
    "assets/tools_icon/spade.jpg",
    688,
    "The Spade is a heavy-duty digging tool designed for excavating soil, transplanting plants, and other gardening tasks. Its sturdy construction and ergonomic handle make it a reliable choice for outdoor work.",
    {
      "Type": "Spade",
      "Material": "High-quality Steel and Wood",
      "Weight": "688 grams",
      "Length": "Standard",
      "Features": "Flat blade, ergonomic handle",
      "Application": "Digging, transplanting, gardening"
    }
  ],

  ["Sponge",
    "assets/tools_icon/sponge.png",
    188,
    "The Sponge is an essential tool for cleaning and finishing surfaces in construction and DIY projects. Its absorbent material and compact size make it convenient for various tasks.",
    {
      "Type": "Sponge",
      "Material": "Absorbent Sponge",
      "Weight": "188 grams",
      "Size": "Standard",
      "Features": "Soft and absorbent",
      "Application": "Cleaning, finishing, wiping surfaces"
    }
  ],

  ["Straight Edge",
    "assets/tools_icon/straight_edge.jpg",
    1623,
    "The Straight Edge is a precision measuring tool used to check the flatness and levelness of surfaces. Its accurate measurements and durable design ensure reliable results for construction and layout work.",
    {
      "Type": "Straight Edge",
      "Material": "High-quality Metal",
      "Length": "1623 mm (64 inches)",
      "Features": "Precision measurement markings",
      "Application": "Checking flatness, levelness, layout"
    }
  ],

  ["Thread",
    "assets/tools_icon/thread.png",
    94,
    "The Thread is a versatile material used for various construction and sewing tasks. Its strong and flexible nature makes it suitable for binding, tying, and hanging objects.",
    {
      "Type": "Thread",
      "Material": "Durable Fiber",
      "Length": "Standard",
      "Features": "Strong and flexible",
      "Application": "Binding, tying, hanging objects"
    }
  ],

  ["Tinner's Hammer",
    "assets/tools_icon/timmer_hammer.png",
    375,
    "The Tinner's Hammer is a specialized tool used for sheet metal work and roofing projects. Its lightweight design and narrow head make it suitable for precise and controlled strikes.",
    [
      "Tinner's Hammer",
      "High-quality Steel and Wood",
      "375 grams",
      "Standard",
       "Narrow head, lightweight",
       "Sheet metal work, roofing"
    ]
  ],

  ["Torpedo Level",
    "assets/tools_icon/torpedo_level.png",
    863,
    "The Torpedo Level is a compact and versatile tool used for checking horizontal and vertical alignment. Its vials and magnetic base ensure accurate measurements and hands-free operation.",
    {
      "Type": "Torpedo Level",
      "Material": "Durable Plastic and Metal",
      "Length": "863 mm (34 inches)",
      "Features": "Multiple vials, magnetic base",
      "Application": "Checking alignment, leveling"
    }
  ],

  ["Wheel Barrow",
    "assets/tools_icon/wheel_barrow.png",
    10625,
    "The Wheel Barrow is an indispensable tool for transporting heavy materials and construction debris. Its sturdy construction and large capacity make it a reliable choice for various construction tasks.",
    {
      "Type": "Wheel Barrow",
      "Material": "Heavy-duty Metal and Rubber",
      "Capacity": "10625 cubic cm",
      "Features": "Large capacity, durable construction",
      "Application": "Transporting materials, debris, construction tasks"
    }
  ]
];

//
List images = [
  "assets/images/intro_image1.jpg",
  "assets/images/intro_image2.jpg",
  "assets/images/intro_image3.jpg",
  "assets/images/construction.jpg"
];

// Text(product[4]['Type'],style: txt_simple_nunito(fontSize: 12.sp),),
// Text(product[4]['Material'],style: txt_simple_nunito(fontSize: 12.sp),),
// Text(product[4]['Length'],style: txt_simple_nunito(fontSize: 12.sp),),
// Text(product[4]['Features'],style: txt_simple_nunito(fontSize: 12.sp),),
// Text(product[4]['Application'],style: txt_simple_nunito(fontSize: 12.sp),),
