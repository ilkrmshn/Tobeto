void main() {
  ft_armstrong(153);
}

void ft_armstrong(int n) {
  int number, remainder, result = 0;

  number = n;
  while (number != 0) {
    remainder = number % 10;
    result += remainder * remainder * remainder;
    number ~/= 10;
  }

  if (result == n)
    print("$n  Armstrong Sayısıdır.");
  else
    print("$n Armstrong Sayısı değildir.");
}
