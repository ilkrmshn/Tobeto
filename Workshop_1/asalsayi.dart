void main() {
  ft_prime(50);
}

void ft_prime(int n) {
  int i, num, count;
  for (num = 1; num <= n; num++) {
    count = 0;
    for (i = 2; i <= num / 2; i++) {
      if (num % i == 0) {
        count++;
        break;
      }
    }
    if (count == 0 && num != 1) print(num);
  }
}
