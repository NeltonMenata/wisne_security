class Emergency {
  final String phone;
  final String name;
  final List<String>? block;
  final String type;
  final String? consignee;

  Emergency(
      {this.phone = "",
      this.name = "",
      this.consignee,
      this.block,
      this.type = ""});
}
