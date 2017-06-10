class Transfer {
  String firstname;
  String lastname;
  String country;
  String phonenumber;
  String amount;
  String fee;
  DateTime senddate;
  String sender;

  Transfer(this.firstname, this.lastname, this.country, this.phonenumber,
      this.amount, this.fee, this.senddate);

  Transfer.fromFields(List<String> fields){
    firstname = fields[0];
    lastname = fields[1];
    country = fields[2];
  }
}

class TransferData {

  TransferData(this._data);

  final List<List<String>> _data;


}