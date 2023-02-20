#include <stdio.h>
#include "lib.h"

#define SIGN_AND_MAGNITUDE 1
#define ONE_COMPLEMENT 2
#define TWO_COMPLEMENT 3

void sign_and_magnitude(char *strDec, int *binary, int bit) {

  convert(absolute(strToint(strDec)), binary, bit);
  binary[0] = sign(strDec);
}

void one_complement(char *strDec, int *binary, int bit) {

  int decimal = strToint(strDec);
  convert(absolute(decimal), binary, bit);
  if (strDec[0] == '-') {
    invert(binary, bit);
  }
}

void two_complement(char *strDec, int *binary, int bit) {

  int decimal = strToint(strDec);
  convert(absolute(decimal), binary, bit);
  if (decimal < 0) {
    invert(binary, bit);
    increase(binary, bit);
  }
}

void render(int method, char *strDec, int bit) {

  int binary[bit];
  switch (method) {
  case SIGN_AND_MAGNITUDE:
    printf("sign and magnitude:\t");
    sign_and_magnitude(strDec, binary, bit);
    break;
  case ONE_COMPLEMENT:
    printf("1's complement:\t\t");
    one_complement(strDec, binary, bit);
    break;
  case TWO_COMPLEMENT:
    printf("2's complement:\t\t");
    two_complement(strDec, binary, bit);
    break;
  }
  for (int i = 0; i < bit; i++) {
    printf("%d", binary[i]);
  }
  printf("\n");
}

int main(void) {

  char strDec[100];
  int bit = 4;
  printf("decimal: ");
  scanf("%[^\n]s",strDec);
  printf("bit: ");
  scanf("%d", &bit);
  render(SIGN_AND_MAGNITUDE, strDec, bit);
  render(ONE_COMPLEMENT, strDec, bit);
  render(TWO_COMPLEMENT, strDec, bit);
  return (0);
}