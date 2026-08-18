class RegisterRequest{
  String? email ;
  String? name ;
  String? password ;
  String? rePassword ;
  String? phone ;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword
});
}