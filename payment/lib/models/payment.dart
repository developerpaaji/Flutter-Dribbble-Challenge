
class Payment{

  String _partyPic,_partyName,_category;
  String _time;
  double _amount;
  int _paymentType;

  Payment(this._partyPic, this._partyName, this._category, this._time,
      this._amount, this._paymentType):
      assert(_paymentType!=0);

  int get type => _paymentType;

  double get amount => _amount;

  String get time => _time;

  get category => _category;

  get partyName => _partyName;

  String get partyPic => _partyPic;

}