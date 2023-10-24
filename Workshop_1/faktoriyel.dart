void main() {
  ft_faktoriyel(4);
}

void ft_faktoriyel(int n) {
  int faktoriyel = 1;

  for (int i = 1; i <= n; i++) {
    faktoriyel *= i;
  }
  print(faktoriyel);
}
