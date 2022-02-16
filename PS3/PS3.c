#include <stdio.h>

int main(void) {

  int R0 = 0;       // Copy 0 to R0
  int R1 = 0;       // Copy 0 to R1
  int R2 = 1;       // Copy 1 to R2
  int R3 = 1;       // Copy 1 to R3
  do {              // DO-WHILE LOOP
    R0 = R1 + R2;   // Add R1 with R2 then store in R0
    R1 = R2;        // Moving value of R2 to R1
    R2 = R0;        // Moving value of R0 to R2
    R3 = R3 + 1;    // Increase R3 by 1
  } while (R3 < 44);// Compare to check
  
  printf("%d\n", R0);

  return (0);
}
