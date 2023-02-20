#include<stdio.h>

int absolute(int decimal);
int sign(char *strDec);
int strToint(char *strDec);
void padding(int *binary, int bit);
void invert(int *binary, int bit);
void increase(int *binary, int bit);
void convert(int decimal, int *binary, int bit);