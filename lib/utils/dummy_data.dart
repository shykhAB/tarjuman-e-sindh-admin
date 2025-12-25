/*
*  Created By: Abdul Salam on 11-Oct-2025
*/


import 'package:get/get.dart';

class DummyData {

  // static List<ItemModel> get getNewsCategories => [
  //   ItemModel('Latest', 'تازا ترين'),
  //   ItemModel('Pakistan', 'پاڪستان'),
  //   ItemModel('World', 'دنيا'),
  //   ItemModel('Sports', 'رانديون'),
  //   ItemModel('Showbiz', 'شوبز'),
  //   ItemModel('Interesting & Economy', 'دلچسپ ۽ معيشت')
  // ];

  static List<String> get getNewsCategories => [
    'تازا ترين',
    'پاڪستان',
    'دنيا',
    'رانديون',
    'شوبز',
    'دلچسپ ۽ معيشت'
  ];

  // static RxList<NewsModel> get getNewsList => [
  // NewsModel(id: 1, heading: "اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو", detail: "تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن.", image: "https://via.placeholder.com/600x400", category: "پاڪستان", createdAt: "1 Hour Ago", createdBy: "Abdul Salam"),
  // NewsModel(id: 2, heading: "اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو", detail: "تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن.", image: "https://via.placeholder.com/600x400", category: "پاڪستان", createdAt: "1 Hour Ago", createdBy: "Abdul Salam"),
  // NewsModel(id: 3, heading: "اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو", detail: "تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن.", image: "https://via.placeholder.com/600x400", category: "پاڪستان", createdAt: "1 Hour Ago", createdBy: "Abdul Salam"),
  // NewsModel(id: 4, heading: "اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو", detail: "تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن.", image: "https://via.placeholder.com/600x400", category: "پاڪستان", createdAt: "1 Hour Ago", createdBy: "Abdul Salam"),
  // NewsModel(id: 5, heading: "اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو", detail: "تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن.", image: "https://via.placeholder.com/600x400", category: "پاڪستان", createdAt: "1 Hour Ago", createdBy: "Abdul Salam"),
  // ].obs;


  static RxList<Map<String, dynamic>> breakingNews = <Map<String, dynamic>>[
    {
      'title': 'نیشنل اسمبلی ۾ اهم ترقياتي پيش رفت',
      'image': 'https://via.placeholder.com/400x250',
      'category': 'National',
      'time': '2 hours ago',
    },
    {
      'title': 'بين الاقوامي اجلاس تاريخي معاهدي سان ختم ٿيو',
      'image': 'https://via.placeholder.com/400x250',
      'category': 'International',
      'time': '3 hours ago',
    },
    {
      'title': 'مقامي ٽيم دلچسپ ميچ بعد چيمپيئن بڻجي وئي',
      'image': 'https://via.placeholder.com/400x250',
      'category': 'Sports',
      'time': '5 hours ago',
    },
    {
      'title': 'مقامي ٽيم دلچسپ ميچ بعد چيمپيئن بڻجي وئي',
      'image': 'https://via.placeholder.com/400x250',
      'category': 'Sports',
      'time': '5 hours ago',
    },
    {
      'title': 'مقامي ٽيم دلچسپ ميچ بعد چيمپيئن بڻجي وئي',
      'image': 'https://via.placeholder.com/400x250',
      'category': 'Sports',
      'time': '5 hours ago',
    },
  ].obs;
  static RxList<Map<String, dynamic>> topStories = <Map<String, dynamic>>[
    {
      'title': 'اقتصادي سڌارن مارڪيٽ تي مثبت اثر ڏيکاريو',
      'excerpt': 'تازين اقتصادي پاليسين مختلف شعبن ۾ اميد افزا نتيجا ڏيکارڻ شروع ڪيا آهن...',
      'image': 'https://via.placeholder.com/600x400',
      'category': 'Business',
      'time': '1 hour ago',
      'author': 'Ahmed Khan',
      'views': '12.5K',
    },
    {
      'title': 'وڏي شهر ۾ نئون ٽيڪنالاجي مرڪز کوليو ويو',
      'excerpt': 'هي جديد سهولت هزارين نوڪريون پيدا ڪرڻ ۽ جدت کي وڌائڻ جو وعدو ڪري ٿي...',
      'image': 'https://via.placeholder.com/600x400',
      'category': 'Technology',
      'time': '4 hours ago',
      'author': 'Sara Ali',
      'views': '8.2K',
    },
    {
      'title': 'ثقافتي ميلي ۾ روايتي ورثي جو جشن',
      'excerpt': 'هزارين ماڻهو شاندار پرفارمنسن ۽ روايتي فنون جي نمائش ڏسڻ لاءِ گڏ ٿيا...',
      'image': 'https://via.placeholder.com/600x400',
      'category': 'Entertainment',
      'time': '6 hours ago',
      'author': 'Fatima Sheikh',
      'views': '5.7K',
    },
  ].obs;

// Latest News Data
  static RxList<Map<String, dynamic>> latestNews = <Map<String, dynamic>>[
    {
      'title': 'تازيون خبرون: عنوان 1',
      'excerpt': 'خبر واري مضمون جي مختصر وضاحت هتي ڏني ويندي...',
      'image': 'https://via.placeholder.com/300x200',
      'time': '1 hour ago',
    },
    {
      'title': 'تازيون خبرون: عنوان 2',
      'excerpt': 'خبر واري مضمون جي مختصر وضاحت هتي ڏني ويندي...',
      'image': 'https://via.placeholder.com/300x200',
      'time': '2 hours ago',
    },
    {
      'title': 'تازيون خبرون: عنوان 3',
      'excerpt': 'خبر واري مضمون جي مختصر وضاحت هتي ڏني ويندي...',
      'image': 'https://via.placeholder.com/300x200',
      'time': '3 hours ago',
    },
    {
      'title': 'تازيون خبرون: عنوان 4',
      'excerpt': 'خبر واري مضمون جي مختصر وضاحت هتي ڏني ويندي...',
      'image': 'https://via.placeholder.com/300x200',
      'time': '4 hours ago',
    },
    {
      'title': 'تازيون خبرون: عنوان 5',
      'excerpt': 'خبر واري مضمون جي مختصر وضاحت هتي ڏني ويندي...',
      'image': 'https://via.placeholder.com/300x200',
      'time': '5 hours ago',
    },
  ].obs;



}
