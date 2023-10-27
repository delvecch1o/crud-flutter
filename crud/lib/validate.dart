bool isValidFrota(String frota) {
  return frota.isEmpty ||
      RegExp(r'[!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(frota);
}

bool isValidModelo(String modelo) {
  return modelo.isEmpty ||
      RegExp(r'[!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(modelo);
}

bool isValidSetor(String setor) {
  return setor.isEmpty ||
      RegExp(r'[!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(setor);
}

bool isValidDescricao(String descricao) {
  return descricao.isEmpty ||
      RegExp(r'[!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(descricao);
}

