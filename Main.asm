; Compile using "compile.bat"

.386
.model flat, stdcall
option casemap:none

; Include necessary libraries
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc

; Library links
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib

.data
    ; Prompts
    titlePrompt       BYTE "Calorie Calculator", 13, 10, 0
    unitPrompt1       BYTE "Units:", 13, 10, \
                      "(1) US Units: Age, Sex, Height (Feet & Inches), Weight (Pounds), Activity", 13, 10, 0
    unitPrompt2       BYTE "(2) Metric Units: Age, Sex, Height (Centimeters), Weight (Kilograms), Activity", 13, 10, \
                      "Select Units: ", 0
    agePrompt         BYTE "Enter Your Age: ", 0
    genderPrompt1     BYTE "Sex:", 13, 10, \
                      "(1) Male", 13, 10, 0
    genderPrompt2     BYTE "(2) Female", 13, 10, \
                      "Enter Your Sex: ", 0
    heightFeetPrompt  BYTE "Enter Your Height (Feet): ", 0
    heightInchesPrompt BYTE "Enter Your Height (Inches): ", 0
    weightPoundsPrompt BYTE "Enter Your Weight (Pounds): ", 0
    heightCmPrompt    BYTE "Enter Your Height (Centimeters): ", 0
    weightKgPrompt    BYTE "Enter Your Weight (Kilograms): ", 0
    activityPrompt1   BYTE "Activities:", 13, 10, \
                      "(1) Sedentary: little or no exercise", 13, 10, \
                      "(2) Light: exercise 1-3 times a week", 13, 10, 0
    activityPrompt2   BYTE "(3) Moderate: exercise 4-5 times a week", 13, 10, \
                      "(4) Active: daily exercise or intense exercise 3-4 times a week", 13, 10, \
                      "(5) Very Active: intense exercise 6-7 times a week", 13, 10, \
                      "(6) Extra Active: very intense exercise daily, or physical job", 13, 10, \
                      "Enter Your Activity: ", 0

    ; Error messages
    invalidInputMsg   BYTE "Invalid input. Please try again.", 13, 10, 0

    ; Input buffers
    inputBuffer       BYTE 10 DUP(0)

    ; Variables
    unitSelection     DWORD 0
    age               DWORD 0
    genderSelection   DWORD 0
    heightFeet        DWORD 0
    heightInches      DWORD 0
    heightCm          DWORD 0
    weightPounds      DWORD 0
    weightKg          DWORD 0
    activitySelection DWORD 0

.code
start:
    ; Display title
    invoke StdOut, ADDR titlePrompt
    invoke StdOut, ADDR unitPrompt1
    invoke StdOut, ADDR unitPrompt2

    ; Unit Selection
UnitSelectionLoop:
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov unitSelection, eax
    cmp unitSelection, 1
    je USUnitSelection
    cmp unitSelection, 2
    je MetricUnitSelection
    invoke StdOut, ADDR invalidInputMsg
    jmp UnitSelectionLoop

    ; US Units Input
USUnitSelection:
    invoke StdOut, ADDR agePrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov age, eax

    invoke StdOut, ADDR genderPrompt1
    invoke StdOut, ADDR genderPrompt2
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov genderSelection, eax

    invoke StdOut, ADDR heightFeetPrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov heightFeet, eax

    invoke StdOut, ADDR heightInchesPrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov heightInches, eax

    invoke StdOut, ADDR weightPoundsPrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov weightPounds, eax

    jmp ActivitySelection

    ; Metric Units Input
MetricUnitSelection:
    invoke StdOut, ADDR agePrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov age, eax

    invoke StdOut, ADDR genderPrompt1
    invoke StdOut, ADDR genderPrompt2
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov genderSelection, eax

    invoke StdOut, ADDR heightCmPrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov heightCm, eax

    invoke StdOut, ADDR weightKgPrompt
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov weightKg, eax

    ; Activity Level Selection
ActivitySelection:
    invoke StdOut, ADDR activityPrompt1
    invoke StdOut, ADDR activityPrompt2
    invoke StdIn, ADDR inputBuffer, 10
    invoke atodw, ADDR inputBuffer
    mov activitySelection, eax
    cmp activitySelection, 1
    jl InvalidActivity
    cmp activitySelection, 6
    jg InvalidActivity
    jmp ValidActivity

InvalidActivity:
    invoke StdOut, ADDR invalidInputMsg
    jmp ActivitySelection

ValidActivity:
    ; Exit Program
    invoke ExitProcess, 0

end start
