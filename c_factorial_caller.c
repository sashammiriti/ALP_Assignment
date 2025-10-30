// Filename: c_factorial_caller.c
// Description: C program to read user input and call an external Assembly function (factorial).

#include <stdio.h>
#include <limits.h>

// External function definition for the Assembly code.
// The Assembly function 'factorial' takes an int and returns a long long.
extern long long factorial(int n);

int main() {
    int input_num;
    long long result;

    printf("--- C Program Calling Assembly Factorial ---\n");
    printf("Enter a non-negative integer (N <= 20 for accurate results): ");

    // Read user input
    if (scanf("%d", &input_num) != 1) {
        fprintf(stderr, "Invalid input. Exiting.\n");
        return 1;
    }

    // Input validation
    if (input_num < 0) {
        printf("Factorial is only defined for non-negative integers.\n");
        return 1;
    }

    // Check for overflow (20! is the largest standard long long can hold)
    if (input_num > 20) {
        printf("Warning: %d! will likely cause an overflow, displaying 20! max.\n", input_num);
        input_num = 20; // Cap input for reliable output demonstration
    }

    // Call the Assembly function!
    // The C compiler handles passing 'input_num' into RDI.
    // The result is received back from RAX into the 'result' variable.
    result = factorial(input_num);

    printf("\nFactorial of %d is: %lld\n", input_num, result);

    return 0;
}
