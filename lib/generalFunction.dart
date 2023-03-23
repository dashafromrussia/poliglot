class GeneralFunction{

  static String getTime(int time){
    String resultime ='';
    final int dateMess = time is int ? time : 0;
    final today = DateTime.now().toUtc().millisecondsSinceEpoch;
    final tomorrow = DateTime.now().toUtc().add(const Duration(hours: 24)).millisecondsSinceEpoch;
    final oneDayMilliSeconds = tomorrow - today;
    final differenceDay = today - dateMess;
    if(differenceDay < oneDayMilliSeconds){
      resultime = '${(DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).minute}';
    }else if(differenceDay > oneDayMilliSeconds){
      resultime = '${(DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(dateMess,isUtc:false).minute}';
    }
    return resultime;
  }
}