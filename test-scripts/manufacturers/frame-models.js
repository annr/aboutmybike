
// sources for models:

//https://en.wikipedia.org/wiki/GT_Bicycles



// local manufacturer id 3230

var surlyFrameModels = [
  "Big Dummy",
  "Conundrum",
  "Instigator",
  "1x1",
  "Steamroller",
  "Pacer",
  "Cross-Check",
  "Cross-Check SS",
  "Straggler",
  "Straggler 650b",
  "Travellers Check",
  "Long Haul Trucker",
  "Disc Trucker",
  "Trucker Deluxe",
  "Troll",
  "World Troller",
  "Karate Monkey",
  "Ogre",
  "Krampus",
  "Moonlander",
  "Ice Cream Truck"
];

for (var i = 0; i < surlyFrameModels.length; i++) {
  console.log("INSERT INTO model (manufacturer_id, name) VALUES (3230, '" + surlyFrameModels[i] + "');\n");
}