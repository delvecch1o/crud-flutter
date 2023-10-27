bool isValidFrota(String frota) {
  return frota.isEmpty ||
      RegExp(r'[!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(frota);
}

