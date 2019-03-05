
class CreditCard{
  final String _cardNo,_holder,_expiryDate,_cvv,_logo;
  CreditCard(this._cardNo,
      this._logo,
      this._holder,
      this._expiryDate,
      this._cvv):
      assert(_cardNo.length==16);

  String get cardNo
  {
    var letters=[];
    for(int i=0;i<_cardNo.length;)
      {
          letters.add(_cardNo.substring(i,((i~/4)+1)*4));
         i+=4;
      }
    var fakeNo="";
    for(int i=0;i<letters.length;i++)
      {
        if(i==letters.length-1)
          {
            fakeNo+=letters[i];
            break;
          }
        fakeNo+="****   ";
      }
    return fakeNo;
  }

  String get holder => _holder;

  String get logo => _logo;

  String get cvv => _cvv;

  String get expiryDate => _expiryDate;

}