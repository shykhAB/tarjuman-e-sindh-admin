
/* Created By: Amjad Jamali on 02-Oct-2023 */
import 'package:intl/intl.dart';

extension StringUtils on String {
  /// Created By: Amjad Jamali on 10-Sep-2023
  bool equalsIgnoreCase(String b) => (replaceAll(' ', '')).toLowerCase() == (b.replaceAll(' ', '')).toLowerCase();
  /// Created By: Amjad Jamali on 02-Oct-2023
  int get toInt => toDouble.ceil();
  /// Created By: Amjad Jamali on 02-Oct-2023
  double get toDouble => double.tryParse(this)??0.0;

  /// Created By: Amjad Jamali on 02-Oct-2023
  String get inRupee{
    final chars = split('');
    String newString = '';
    for (int i = chars.length - 1; i >= 0; i--) {
      if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
        newString = ",$newString";
      }
      newString = chars[i] + newString;
    }
    return "Rs. $newString";
  }

  /// Created By: Amjad Jamali on 09-Oct-2023
  String get formatDate {
    DateTime? dateTime  = DateTime.tryParse(this);
    if(dateTime != null){
       return DateFormat('dd-MM-yyyy').format(dateTime);
    }
    return replaceAll('/', '-');
  }

  String get formatTime12Hrs {
    try{
      return DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(this));
    }catch(_){}
    return this;
  }


  /// Created By: Amjad Jamali on 29-May-2024
  DateTime get parseToDateTime {
    DateTime? dateTime = DateTime.tryParse(this);
    if( dateTime != null) return dateTime;
    try{
      return DateFormat('dd-MM-yyyy').parse(replaceAll('/', '-'));
    }catch(_){}
    return DateTime.now();
  }

  /// Created By: Maryam Shaikh on 29-Aug-2024
  String get phoneFormatWithHyphen {
    if (!contains('-')) {
      return '${substring(0, 4)}-${substring(4)}';
    } else {
      return this;
    }
  }
  String get formatDateWithMonthName {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime == null) {
      final RegExp customDateFormat = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$');
      final match = customDateFormat.firstMatch(this);
      if (match != null) {
        final int day = int.parse(match.group(1)!);
        final int month = int.parse(match.group(2)!);
        final int year = int.parse(match.group(3)!);
        dateTime = DateTime(year, month, day);
      }
    }

    if (dateTime != null) {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    }
    return replaceAll('/', '-');
  }

  String get formatDateWithYear {
    DateTime? dateTime;

    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(this)) {
      return this;
    }
    try {
      dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(this, true);
    } catch (e) {
      try {
        dateTime = DateFormat('dd-MM-yyyy').parse(this);
      } catch (e) {
        return replaceAll('/', '-');
      }
    }
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String get slotTimeFormatted{
    String slotTime = split(',').first;

    List<String> times = slotTime.split('-');
    return "${times.first.formatTime12Hrs} - ${times.last.formatTime12Hrs}";
  }


  String get amountInWords {
    String numberString = '0000000000$this';
    numberString = numberString.substring(length, numberString.length);
    var str = '';
    List<String> ones = [
      '',
      'one ',
      'two ',
      'three ',
      'four ',
      'five ',
      'six ',
      'seven ',
      'eight ',
      'nine ',
      'ten ',
      'eleven ',
      'twelve ',
      'thirteen ',
      'fourteen ',
      'fifteen ',
      'sixteen ',
      'seventeen ',
      'eighteen ',
      'nineteen '
    ];
    List<String> tens = [
      '',
      '',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety'
    ];

    str += (numberString[0]) != '0' ? '${ones[int.parse(numberString[0])]}hundred ' : '';//hundreds
    if ((int.parse('${numberString[1]}${numberString[2]}')) < 20 && (int.parse('${numberString[1]}${numberString[2]}')) > 9) {
      str += '${ones[int.parse('${numberString[1]}${numberString[2]}')]}crore ';
    } else {
      str += (numberString[1]) != '0' ? '${tens[int.parse(numberString[1])]} ' : ''; //tens
      str += (numberString[2]) != '0' ? '${ones[int.parse(numberString[2])]}crore ' : ''; //ones
      str += (numberString[1] != '0') && (numberString[2] == '0') ? 'crore ' : '';
    }
    if ((int.parse('${numberString[3]}${numberString[4]}')) < 20 && (int.parse('${numberString[3]}${numberString[4]}')) > 9) {
      str += '${ones[int.parse('${numberString[3]}${numberString[4]}')]}lakh ';
    } else {
      str += (numberString[3]) != '0' ? '${tens[int.parse(numberString[3])]} ' : ''; //tens
      str += (numberString[4]) != '0' ? '${ones[int.parse(numberString[4])]}lakh ' : ''; //ones
      str += (numberString[3] != '0') && (numberString[4] == '0') ? 'lakh ' : '';
    }
    if ((int.parse('${numberString[5]}${numberString[6]}')) < 20 && (int.parse('${numberString[5]}${numberString[6]}')) > 9) {
      str += '${ones[int.parse('${numberString[5]}${numberString[6]}')]}thousand ';
    } else {
      str += (numberString[5]) != '0' ? '${tens[int.parse(numberString[5])]} ' : ''; //ten thousands
      str += (numberString[6]) != '0' ? '${ones[int.parse(numberString[6])]}thousand ' : ''; //thousands
      str += (numberString[5] != '0') && (numberString[6] == '0') ? 'thousand ' : '';
    }
    str += (numberString[7]) != '0' ? '${ones[int.parse(numberString[7])]}hundred ' : ''; //hundreds
    if ((int.parse('${numberString[8]}${numberString[9]}')) < 20 && (int.parse('${numberString[8]}${numberString[9]}')) > 9) {
      str += ones[int.parse('${numberString[8]}${numberString[9]}')];
    } else {
      str += (numberString[8]) != '0' ? '${tens[int.parse(numberString[8])]} ' : ''; //tens
      str += (numberString[9]) != '0' ? ones[int.parse(numberString[9])] : ''; //ones
    }
    return str;
  }


  String get timeAgo {
    DateTime? dateTime;

    try {
      dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(this);
    } catch (_) {
      try {
        dateTime = DateTime.parse(this);
      } catch (_) {
        return '';
      }
    }

    Duration diff = DateTime.now().difference(dateTime);

    if (diff.isNegative) {
      return 'Just now';
    }

    if (diff.inSeconds < 60) {
      return 'Just now';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    }
    if (diff.inHours < 24) {
      return diff.inHours == 1
          ? '1 hour ago'
          : '${diff.inHours} hours ago';
    }
    if (diff.inDays == 1) {
      return 'Yesterday';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    }

    return DateFormat('dd MMM yyyy').format(dateTime);
  }


}
