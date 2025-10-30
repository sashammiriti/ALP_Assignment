#include <stdio.h>
#include <stdlib.h>

/**
 * @brief Calculates the factorial of a non-negative integer.
 */
int main() {
    int num;
    long long factorial = 1;

    // Prompt user for input
    printf("--- C Factorial Calculator ---\n");
    printf("Enter a non-negative integer (max 20 for accurate results): ");

    // Check if input reading was successful
    if (scanf("%d", &num) != 1) {
        printf("Invalid input. Please enter an integer.\n");
        return 1;
    }

    // Input validation and calculation
    if (num < 0) {
        printf("Error: Factorial is not defined for negative numbers.\n");
    } else if (num == 0) {
        printf("Factorial of 0 is 1.\n");
    } else {
        for (int i = 1; i <= num; i++) {
            factorial *= i;
        }
        printf("Factorial of %d is %lld.\n", num, factorial);
    }

    return 0;
}
