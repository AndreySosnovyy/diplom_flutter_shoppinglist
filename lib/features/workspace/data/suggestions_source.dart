import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';

// todo: add images urls
class SuggestionsSource {
  SuggestionsSource() {
    suggestions.sort((a, b) => a.name.compareTo(b.name));
  }

  final List<Suggestion> suggestions = <Suggestion>[
    Suggestion(
      name: 'Колбаса вареная',
      imageUrl: 'https://sibprod.info/upload/iblock/503/50323e50cd7d76d3426b3c6b06eb620b.png',
    ),
    Suggestion(
      name: 'Колбаса',
      imageUrl: 'https://e7.pngegg.com/pngimages/245/459/png-clipart-sausage-sausage.png',
    ),
    Suggestion(
      name: 'Сыр',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfX7dOcVLGcP_YLViKrUodyBEKRUcBT8zMVw&usqp=CAU',
    ),
    Suggestion(
      name: 'Хлеб белый',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Хлеб черный',
      imageUrl: 'https://img2.freepng.ru/20180607/ygl/kisspng-graham-bread-rye-bread-pumpernickel-bublik-borodin-5b19171c3bbb17.9358279015283709722447.jpg',
    ),
    Suggestion(
      name: 'Яблоки',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Бананы',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Молоко',
      imageUrl: 'https://e7.pngegg.com/pngimages/506/654/png-clipart-milk-bottle-milk-bottle-drink-milk-rectangle-pink.png',
      unit: Unit.liter,
    ),
    Suggestion(
      name: 'Сметана',
      imageUrl: 'https://img1.freepng.ru/20180330/bzw/kisspng-sour-cream-fajita-gratin-omelette-cream-5abf04d28cb072.7984592615224680505763.jpg',
    ),
    Suggestion(
      name: 'Селедка',
      imageUrl: 'https://static5.depositphotos.com/1000579/467/i/450/depositphotos_4675916-stock-photo-herring-plate-gerbs-lemon.jpg?forcejpeg=true',
    ),
    Suggestion(
      name: 'Морковь',
      imageUrl: 'https://w7.pngwing.com/pngs/517/983/png-transparent-carrot-fig-carrot-vegetables-fruit-thumbnail.png',
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Капуста',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Картофель',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Огурцы',
      imageUrl: 'https://envato-shoebox-0.imgix.net/7d03/9561-82ab-4aa4-a147-9733f03381b9/FreshSnackCucumberInWoodenBowl.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=700&s=074c976a625f64f0a33c6254a85bf6ad',
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Помидоры',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Чай',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Кофе',
      imageUrl: 'https://www.pngplay.com/wp-content/uploads/7/Cafe-Coffee-PNG-HD-Quality.png',
    ),
    Suggestion(
      name: 'Печенье',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Булочка',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Кошачий корм',
      imageUrl: 'https://img2.freepng.ru/20180615/jr/kisspng-cat-food-dog-prescription-diet-c-d-urinary-care-ca-dry-chicken-5b23794bddc515.8383219215290514679084.jpg',
    ),
    Suggestion(
      name: 'Собачий корм',
      imageUrl: 'https://w7.pngwing.com/pngs/999/885/png-transparent-cat-food-dog-hill-s-pet-nutrition-science-diet-cat-thumbnail.png',
    ),
    Suggestion(
      name: 'Куриное филе',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Свинина',
      imageUrl: null,
      unit: Unit.kilos,
    ),
    Suggestion(
      name: 'Сок',
      imageUrl: 'https://img1.freepng.ru/20180219/ooe/kisspng-orange-juice-pineapple-jus-dananas-fruit-pineapple-juice-5a8b7c878f0143.1766474415190908235858.jpg',
      unit: Unit.liter,
    ),
    Suggestion(
      name: 'Сосиски',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Горошек',
      imageUrl: 'https://img1.freepng.ru/20180621/gss/kisspng-pea-vegetarian-cuisine-natural-foods-superfood-green-peas-5b2c3b6997e1d6.8572081315296254496221.jpg',
    ),
    Suggestion(
      name: 'Кукуруза',
      imageUrl: 'https://e3.edimdoma.ru/data/ingredients/0000/3306/3306-ed4_wide.jpg?1487748439',
    ),
    Suggestion(
      name: 'Кетчуп',
      imageUrl: 'https://img1.freepng.ru/20180627/agv/kisspng-ketchup-barbecue-sauce-french-fries-vinegar-mcdona-ketchup-sauce-5b335ebf9740e7.4303498215300932476195.jpg',
    ),
    Suggestion(
      name: 'Майонез',
      imageUrl: 'https://thumbs.dreamstime.com/b/%D0%BC%D0%B0%D0%B9%D0%BE%D0%BD%D0%B5%D0%B7-%D1%88%D0%B0%D1%80%D0%B0-3371049.jpg',
    ),
    Suggestion(
      name: 'Укроп',
      imageUrl: 'https://w7.pngwing.com/pngs/888/8/png-transparent-dill-herb-salad-vegetable-iceberg-lettuce-salad-leaf-vegetable-soup-food-thumbnail.png',
    ),
    Suggestion(
      name: 'Петрушка',
      imageUrl: 'https://static7.depositphotos.com/1011268/681/i/450/depositphotos_6817160-stock-photo-parsley.jpg?forcejpeg=true',
    ),
    Suggestion(
      name: 'Йогурт',
      imageUrl: 'https://pngimg.com/uploads/yogurt/yogurt_PNG15190.png',
    ),
    Suggestion(
      name: 'Кефир',
      imageUrl: 'https://img1.freepng.ru/20190208/qbl/kisspng-kefir-soy-milk-plant-milk-drink-proteinaholic-is-it-time-to-sober-up-from-animal-5c5e35e0b11bb4.3224670715496780487254.jpg',
    ),
    Suggestion(
      name: 'Апельсины',
      imageUrl: 'https://cdn.pixabay.com/photo/2016/03/03/17/15/fruit-1234657__480.png',
    ),
    Suggestion(
      name: 'Вино',
      imageUrl: null,
      unit: Unit.liter,
    ),
    Suggestion(
      name: 'Пиво',
      imageUrl: 'https://w7.pngwing.com/pngs/116/398/png-transparent-ice-beer-decoration-pattern-icy-beer-glass.png',
      unit: Unit.liter,
    ),
    Suggestion(
      name: 'Яйца',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Рыбные консервы',
      imageUrl: null,
    ),
    Suggestion(
      name: 'Мороженное',
      imageUrl: 'https://thumbs.dreamstime.com/b/%D0%B2%D0%BA%D1%83%D1%81%D0%BD%D1%8B%D0%B9-%D0%B2%D0%B5%D1%82%D1%80%D0%BE%D1%83-%D0%BE%D0%B2%D0%B8%D1%82%D0%B5-%D1%8C-%D0%B7%D0%B0%D0%BC%D0%BE%D1%80%D0%BE%D0%B6%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BC%D0%BE%D1%80%D0%BE%D0%B6%D0%B5%D0%BD%D0%BE%D0%B3%D0%BE-%D0%B8%D1%82%D0%B0-%D1%8C%D1%8F%D0%BD%D0%BA%D0%B8-%D0%BA%D0%BE%D1%84%D0%B5-87983502.jpg',
    ),
    Suggestion(
      name: 'Шоколадка',
      imageUrl: 'https://png.pngtree.com/png-vector/20201124/ourmid/pngtree-large-and-small-pieces-of-twill-chocolate-stacked-png-image_2465216.jpg',
      unit: Unit.grams,
    ),
    Suggestion(
      name: 'Макароны',
      imageUrl: 'https://png.pngtree.com/png-clipart/20201218/ourmid/pngtree-delicious-wheat-noodles-in-a-circle-png-image_2585479.jpg',
    ),
    Suggestion(
      name: 'Гречка',
      imageUrl: null,
    ),
  ];
}
