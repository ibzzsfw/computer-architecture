#include <stdio.h>

#define SIGN_AND_MAGNITUDE 1
#define ONE_COMPLEMENT 2
#define TWO_COMPLEMENT 3
#define BIT_DEFAULT 4

int absolute(int decimal);
int power(int base, int exponent);
int sign(char *strDec);
int str_to_int(char *strDec);
void padding(int *binary, int bit);
void convert(int decimal, int *binary, int bit);
int validate(char *strDec, int lower, int upper);
void render(int method, int *binary, int valid, int bit);
void print_array(int *binary, int bit);

void sign_and_magnitude(char *strDec, int *binary, int bit) {

  convert(absolute(str_to_int(strDec)), binary, bit);
  binary[0] = sign(strDec);
}

void one_complement(char *strDec, int *binary, int bit) {

  int decimal = (strDec[0] == '-')
                    ? power(2, bit) - 1 - absolute(str_to_int(strDec))
                    : str_to_int(strDec);
  convert(decimal, binary, bit);
}

void two_complement(char *strDec, int *binary, int bit) {

  int decimal = (strDec[0] == '-')
                    ? power(2, bit) - absolute(str_to_int(strDec))
                    : str_to_int(strDec);
  convert(decimal, binary, bit);
}

void represent(int method, char *strDec, int bit) {

  int binary[bit];
  int lower = -(power(2, bit - 1) - 1);
  int upper = absolute(lower);
  lower = (method == TWO_COMPLEMENT) ? (lower - 1) : (lower);
  int valid = validate(strDec, lower, upper);

  if (valid) {
    switch (method) {
    case SIGN_AND_MAGNITUDE:
      sign_and_magnitude(strDec, binary, bit);
      break;
    case ONE_COMPLEMENT:
      one_complement(strDec, binary, bit);
      break;
    case TWO_COMPLEMENT:
      two_complement(strDec, binary, bit);
      break;
    }
  }

  render(method, binary, valid, bit);
}

int main(void) {

  char strDec[33];
  int bit = BIT_DEFAULT;
  printf("decimal: ");
  scanf("%[^\n]s", strDec);
  /* default is 4, uncomment to modify. */
  // printf("bit: ");
  // scanf("%d", &bit);
  represent(SIGN_AND_MAGNITUDE, strDec, bit);
  represent(ONE_COMPLEMENT, strDec, bit);
  represent(TWO_COMPLEMENT, strDec, bit);
  return (0);
}

/* Library */

int absolute(int decimal) { return (decimal < 0) ? (decimal * (-1)) : decimal; }

int power(int base, int exponent) {

  int result = 1;
  while (exponent-- != 0) {
    result *= base;
  }
  return (result);
}

int sign(char *strDec) { return (strDec[0] == '-') ? (1) : (0); }

int str_to_int(char *strDec) {

  int i = (strDec[0] == '-' || strDec[0] == '+') ? (1) : (0);
  int intDec = 0;
  while (strDec[i] != '\0') {
    intDec = intDec * 10 + strDec[i++] - '0';
  }
  return ((strDec[0] == '-') ? (intDec * (-1)) : intDec);
}

void padding(int *binary, int bit) {

  for (int i = 0; i < bit; i++) {
    binary[i] = 0;
  }
}

void convert(int decimal, int *binary, int bit) {

  padding(binary, bit);
  for (int i = bit - 1; decimal > 0; i--) {
    binary[i] = decimal % 2;
    decimal /= 2;
  }
}

int validate(char *strDec, int lower, int upper) {

  return (str_to_int(strDec) >= lower && str_to_int(strDec) <= upper) ? (1)
                                                                      : (0);
}

void render(int method, int *binary, int valid, int bit) {

  switch (method) {
  case SIGN_AND_MAGNITUDE:
    printf("sign and magnitude:\t");
    break;
  case ONE_COMPLEMENT:
    printf("1's complement:\t\t");
    break;
  case TWO_COMPLEMENT:
    printf("2's complement:\t\t");
    break;
  }

  if (!valid) {
    printf("Invalid, out of range.\n");
  } else {
    print_array(binary, bit);
  }
}

void print_array(int *binary, int bit) {

  for (int i = 0; i < bit; i++) {
    printf("%d", binary[i]);
  }
  printf("\n");
}
