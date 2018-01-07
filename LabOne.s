@ Nate McCain, Lab One, Newman

@ output messages
.data

beginPrintingEvenNums: .asciz "Now summing all even numbers between 1 and 25. \n"
beginPrintingOddNums: .asciz "Now summing all odd numbers between 1 and 25. \n"

currentNum: .asciz "%d \n"

evenSummation: .asciz "The sum of all even numbers between 1 and 25 is %d. \n\n"
oddSummation: .asciz "The sum of all odd numbers between 1 and 25 is %d. \n\n"
totalSummation: .asciz "The sum of all numbers between 1 and 25 is %d. \n\n"

@ declaring the other stuff

.text
    .global main
    .extern printf

@ Start of the main function

main:
    MOV R5, #0  @ The odd summation.
    MOV R6, #0  @ The even summation.
    MOV R10, #0 @ The total summation.

    @ Print message indicating the start of the even summation.
    LDR R0, =beginPrintingEvenNums
    BL printf

    MOV R4, #2  @ Holds the counter (starting with even numbers).
    B evenCounter   @ Begin adding all even numbers.

@------------------------------------------------------------------
@ This function outputs all even numbers between 1 and 25 and adds
@ them to the even summation. When the counter is greater than 25,
@ it branches out to the even summation output function.

evenCounter:
    CMP R4, #25
    BGT evenSumFinished @ Branch if counter is over 25.

    @ Print the current number. R4=counter.
    MOV R1, R4
    LDR R0, =currentNum
    BL printf

    ADD R6, R6, R4  @ Adding to the sum of even numbers.
    ADD R4, R4, #2  @ Incrementing the even counter.
    B evenCounter

@------------------------------------------------------------------
@ This function outputs the even summation, prepares to the counter
@ for the odd summation, and then branches to the odd counter function.

evenSumFinished:
    @ Print the sum of all even numbers. R6=even summation.
    MOV R1, R6
    LDR R0, =evenSummation
    BL printf

    @ Print message indicating the start of the odd summation.
    LDR R0, =beginPrintingOddNums
    BL printf

    MOV R4, #1  @ Prepare the counter for the odd summation.
    B oddCounter

@------------------------------------------------------------------
@ This function outputs all odd numbers between 1 and 25 and adds
@ them to the odd summation. When the counter is greater than 25,
@ it branches out to the odd summation output function.

oddCounter:
    CMP R4, $25
    BGT oddSumFinished  @ Branch if counter is over 25.

    @ Print the current number. R4=counter.
    MOV R1, R4
    LDR R0, =currentNum
    BL printf

    ADD R5, R5, R4  @ Adding to the sum of odd numbers.
    ADD R4, R4, #2  @ Incrementing the odd counter.
    B oddCounter

@------------------------------------------------------------------
@ This function outputs the odd summation, and then it branches to
@ the final function that adds the two summations together.

oddSumFinished:
    @ Print the sum of all odd numbers. R5=odd summation.
    MOV R1, R5
    LDR R0, =oddSummation
    BL printf

    B finalFunction

@------------------------------------------------------------------
@ This function adds together the even and odd summations, and outputs
@ the result. It then ends the program.

finalFunction:
    ADD R1, R5, R6 @ Add the two summations, and store the result in R1 for output.
    @ Print the total summation message.
    LDR R0, =totalSummation
    BL printf

    @ End the program.
    MOV R0, #0
    MOV R7, #1
    SVC 0
    .end



