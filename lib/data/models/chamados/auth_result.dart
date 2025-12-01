class AuthResult {
  final bool success;
  final String message;
  final String? token;
  final int? id;
  final String? nome;
  final String? email;
  final String? role;

  AuthResult({
    required this.success,
    required this.message,
    this.token,
    this.id,
    this.nome,
    this.email,
    this.role,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      success: true,
      message: "OK",
      token: json["token"],
      id: json["id"],
      nome: json["nome"],
      email: json["email"],
      role: json["role"],
    );
  }

  factory AuthResult.error(String msg) {
    return AuthResult(success: false, message: msg);
  }
}
