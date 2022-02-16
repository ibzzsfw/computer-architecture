#include "lib.h"

int absolute(int decimal) { return (decimal < 0) ? (decimal * (-1)) : decimal; }

int sign(char *strDec) { return (strDec[0] == '-') ? (1) : (0); }

int strToint(char *strDec) {

  int i = (strDec[0] == '-' || strDec[0] == '+') ? (1) : (0);
  int intDec = 0;
  while(strDec[i] != '\0') {
    intDec = intDec * 10 + strDec[i++] - '0';
  }
  return ((strDec[0] == '-') ? (intDec * (-1)) : intDec);
}

void padding(int *binary, int bit) {

  for (int i = 0; i < bit; i++) {
    binary[i] = 0;
  }
}

void invert(int *binary, int bit) {

  for (int i = 0; i < bit; i++) {
    binary[i] = !binary[i];
  }
}

void increase(int *binary, int bit) {

  int i = bit - 1;
  int carry = 0;
  binary[i] = !binary[i];
  do {
    if (binary[i] == 0) {
      binary[i - 1] = !binary[i - 1];
      carry = (binary[i - 1] == 1) ? 0 : 1;
    }
    i--;
  } while (carry == 1 && i >= 0);
}

void convert(int decimal, int *binary, int bit) {

  padding(binary, bit);
  for (int i = bit - 1; decimal > 0; i--) {
    binary[i] = decimal % 2;
    decimal /= 2;
  }
}