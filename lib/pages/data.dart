class InsectInfo {
  final String name;
  final String brief;
  final String code;
  final String image;

  InsectInfo({this.name, this.brief, this.code, this.image});
}
//insect database data list
List<InsectInfo> inData = [
  new InsectInfo(
      name: "Eocanthecona Bug",
      brief: "Eocanthecona furcellata (Wolff.) (Hemiptera: Pentatomidae) is an important predator for several agriculturally important pests.",
      code: "A",
      image: "assets/images/2.jpeg",),
  new InsectInfo(
      name: "Larva Spodoptera",
      brief: "Spodoptera litura, otherwise known as the tobacco cutworm or cotton leafworm, is a nocturnal moth in the family Noctuidae. S. litura is a serious polyphagous pest in Asia, Oceania, and the Indian subcontinent.",
      code: "B",
      image: "assets/images/1.jpeg",),
  new InsectInfo(
      name: "Red Hairy Catterpillar",
      brief: "Amsacta albistriga, the red hairy caterpillar, is a moth of the family Erebidae. It is found in southern India. The wingspan is 40–50 mm. The larvae defoliate various agricultural crops.",
      code: "C",
      image: "assets/images/3.jpeg",),
  new InsectInfo(
      name: "Tobacco Catterpillar",
      brief: "Larvae feed on the chlorophyll of the leaves. The eaten leaves give the appearance of whitish yellow web.",
      code: "D",
      image: "assets/images/4.jpeg",),
];
