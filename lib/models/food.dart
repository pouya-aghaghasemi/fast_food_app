// pouya_aghaghasemi

class Food {
  final int foodId;
  final double price;
  final int time;
  final double rating;
  final String category;
  final String foodName;
  final String imageURL;
  bool isFavorite;
  final String description;
  bool isSelected;

  Food({
    required this.foodId,
    required this.price,
    required this.category,
    required this.foodName,
    required this.time,
    required this.rating,
    required this.imageURL,
    required this.isFavorite,
    required this.description,
    required this.isSelected,
  });

  //List of Plants data
  static List<Food> foodList = [
    Food(
      foodId: 0,
      price: 22.00,
      category: 'Breakfast',
      foodName: 'pear & orange',
      time: 20,
      rating: 4.5,
      imageURL: 'assets/images/poore.jpg',
      isFavorite: false,
      description:
          'Pancakes are a delicious breakfast choice served with fresh fruits, maple syrup, chocolate, or honey. Their soft texture and sweet flavor make them a favorite meal for people of all ages around the world.',
      isSelected: false,
    ),
    Food(
      foodId: 1,
      price: 17.00,
      category: 'Breakfast',
      foodName: 'Egg & Bread',
      time: 10,
      rating: 4.8,
      imageURL: 'assets/images/egg.png',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 2,
      price: 37.00,
      category: 'Lunch',
      foodName: 'Meat & Mashrooms',
      time: 30,
      rating: 4.7,
      imageURL: 'assets/images/mushroom_meet.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 3,
      price: 30.00,
      category: 'Lunch',
      foodName: 'kebab',
      time: 25,
      rating: 4.5,
      imageURL: 'assets/images/kebab.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 4,
      price: 24.00,
      category: 'Dessert',
      foodName: 'Sweet pancake',
      time: 10,
      rating: 4.1,
      imageURL: 'assets/images/straw.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 5,
      price: 24.00,
      category: 'Dessert',
      foodName: 'Chocolate cake',
      time: 10,
      rating: 4.4,
      imageURL: 'assets/images/chocklat_Cake.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 6,
      price: 32.00,
      category: 'Dinner',
      foodName: 'Pizza',
      time: 25,
      rating: 4.2,
      imageURL: 'assets/images/pizaa.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 7,
      price: 28.00,
      category: 'Dinner',
      foodName: 'Burger',
      time: 20,
      rating: 4.5,
      imageURL: 'assets/images/burger.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 8,
      price: 6.00,
      category: 'Drink',
      foodName: 'Malt drink',
      time: 0,
      rating: 0.0,
      imageURL: 'assets/images/malt.jpg',
      isFavorite: false,
      description:
          'این گیاه یکی از بهترین گیاهان است. در بیشتر مناطق جهان رشد می کند و می تواند حتی در سخت ترین شرایط آب و هوایی نیز زنده بماند.',
      isSelected: false,
    ),
    Food(
      foodId: 9,
      price: 5.00,
      category: 'Drink',
      foodName: 'Water',
      time: 0,
      rating: 0.0,
      imageURL: 'assets/images/water.jpg',
      isFavorite: false,
      description: 'kossherr',
      isSelected: false,
    ),
  ];

  //Get the favorated items
  static List<Food> getFavoritedFood() {
    List<Food> travelList = Food.foodList;
    return travelList.where((element) => element.isFavorite == true).toList();
  }

  //Get the cart items
  static List<Food> addedToCartFood() {
    List<Food> selectedPlants = Food.foodList;
    return selectedPlants
        .where((element) => element.isSelected == true)
        .toList();
  }
}
