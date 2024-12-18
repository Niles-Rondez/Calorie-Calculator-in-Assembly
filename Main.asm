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
         unitPrompt         BYTE "Select Units (1 for US, 2 for Metric): ", 0
         genderPrompt       BYTE "Select Gender (1 for Male, 2 for Female): ", 0
         heightPrompt       BYTE "Enter your height (centimeters): ", 0
         weightPrompt       BYTE "Enter your weight (kilograms): ", 0
         heightFeetPrompt   BYTE "Enter your height (feet): ", 0
         heightInchesPrompt BYTE "Enter your height (inches): ", 0
         weightPoundsPrompt BYTE "Enter your weight (pounds): ", 0
         
    
    ; Error messages
         invalidUnitMsg     BYTE "Invalid unit selection. Please try again.", 0
         invalidGenderMsg   BYTE "Invalid gender selection. Please try again.", 0
         invalidHeightMsg   BYTE "Invalid height. Please try again.", 0
         invalidWeightMsg   BYTE "Invalid weight. Please try again.", 0
    
    ; Result messages
         unitResultMsg      BYTE "Selected Units: ", 0
         genderResultMsg    BYTE "Selected Gender: ", 0
         heightResultMsg    BYTE "Height: ", 0
         weightResultMsg    BYTE "Weight: ", 0
    
    ; Unit options
         unitUS             BYTE "US", 0
         unitMetric         BYTE "Metric", 0
    
    ; Gender options
         genderMale         BYTE "Male", 0
         genderFemale       BYTE "Female", 0
    
    ; Input buffers
         unitChoice         BYTE 10 dup(0)
         genderChoice       BYTE 10 dup(0)
         heightChoice       BYTE 10 dup(0)
         weightChoice       BYTE 10 dup(0)
         feetChoice         BYTE 10 dup(0)
         inchesChoice       BYTE 10 dup(0)
    
    ; Variables to store selections
         unitSelection      DWORD 0
         genderSelection    DWORD 0
         height             DWORD 0
         weight             DWORD 0
         feet               DWORD 0
         inches             DWORD 0

    ;Carriage return and line feed
         szCrlf             BYTE 13, 10, 0

    ; Feet and Inches strings
         szFeet             BYTE " feet ", 0
         szInches           BYTE " inches", 0
    
.code
    start:                
    ; Units Selection
    UnitSelectionLoop:    
    ; Display unit prompt
                          invoke StdOut, ADDR unitPrompt
        
    ; Get user input
                          invoke StdIn, ADDR unitChoice, 10
        
    ; Convert input to integer
                          invoke atodw, ADDR unitChoice
                          mov    unitSelection, eax
        
    ; Validate unit selection
                          cmp    unitSelection, 1
                          je     ValidUnitSelection
                          cmp    unitSelection, 2
                          je     ValidUnitSelection
        
    ; Invalid selection
                          invoke StdOut, ADDR invalidUnitMsg
                          invoke StdOut, ADDR szCrlf                 ; New line
                          jmp    UnitSelectionLoop

    ValidUnitSelection:   
    
    ; Gender Selection
    GenderSelectionLoop:  
    ; Display gender prompt
                          invoke StdOut, ADDR genderPrompt
        
    ; Get user input
                          invoke StdIn, ADDR genderChoice, 10
        
    ; Convert input to integer
                          invoke atodw, ADDR genderChoice
                          mov    genderSelection, eax
        
    ; Validate gender selection
                          cmp    genderSelection, 1
                          je     ValidGenderSelection
                          cmp    genderSelection, 2
                          je     ValidGenderSelection
        
    ; Invalid selection
                          invoke StdOut, ADDR invalidGenderMsg
                          invoke StdOut, ADDR szCrlf                 ; New line
                          jmp    GenderSelectionLoop

    ValidGenderSelection: 
    
    ; Height and Weight Input
    ; If Metric units selected
                          cmp    unitSelection, 2
                          je     MetricHeightWeight
    
    ; If US units selected
                          cmp    unitSelection, 1
                          je     USHeightWeight

    ; Metric Units: Height in cm, Weight in kg
    MetricHeightWeight:   
    ; Height input (in cm)
                          invoke StdOut, ADDR heightPrompt
                          invoke StdIn, ADDR heightChoice, 10
                          invoke atodw, ADDR heightChoice
                          mov    height, eax
        
    ; Weight input (in kg)
                          invoke StdOut, ADDR weightPrompt
                          invoke StdIn, ADDR weightChoice, 10
                          invoke atodw, ADDR weightChoice
                          mov    weight, eax
                          jmp    DisplayResults
    
    USHeightWeight:       
    ; Height input in feet
                          invoke StdOut, ADDR heightFeetPrompt
                          invoke StdIn, ADDR feetChoice, 10
                          invoke atodw, ADDR feetChoice
                          mov    feet, eax
        
    ; Height input in inches
                          invoke StdOut, ADDR heightInchesPrompt
                          invoke StdIn, ADDR inchesChoice, 10
                          invoke atodw, ADDR inchesChoice
                          mov    inches, eax
        
    ; Weight input in pounds
                          invoke StdOut, ADDR weightPoundsPrompt
                          invoke StdIn, ADDR weightChoice, 10
                          invoke atodw, ADDR weightChoice
                          mov    weight, eax
                          jmp    DisplayResults
    
    DisplayResults:       
    ; Display Results
    ; Unit Result
                          invoke StdOut, ADDR unitResultMsg
                          cmp    unitSelection, 1
                          je     DisplayUS
                          invoke StdOut, ADDR unitMetric
                          jmp    UnitResultDisplayed
    DisplayUS:            
                          invoke StdOut, ADDR unitUS
    UnitResultDisplayed:  
                          invoke StdOut, ADDR szCrlf
    
    ; Gender Result
                          invoke StdOut, ADDR genderResultMsg
                          cmp    genderSelection, 1
                          je     DisplayMale
                          invoke StdOut, ADDR genderFemale
                          jmp    GenderResultDisplayed
    DisplayMale:          
                          invoke StdOut, ADDR genderMale
    GenderResultDisplayed:
                          invoke StdOut, ADDR szCrlf

    ; Height Result
                          invoke StdOut, ADDR heightResultMsg
                          cmp    unitSelection, 1
                          je     DisplayUSHeight
                          invoke dwtoa, height, ADDR heightChoice
                          invoke StdOut, ADDR heightChoice
                          invoke StdOut, ADDR szCrlf
                          jmp    DisplayWeight

    DisplayUSHeight:      
    ; Display feet
                          invoke dwtoa, feet, ADDR feetChoice
                          invoke StdOut, ADDR feetChoice
                          invoke StdOut, ADDR szFeet                 ; Correctly add " feet"
    
    ; Display inches
                          invoke dwtoa, inches, ADDR inchesChoice
                          invoke StdOut, ADDR inchesChoice
                          invoke StdOut, ADDR szInches               ; Correctly add " inches"
                          invoke StdOut, ADDR szCrlf

    DisplayWeight:        
    ; Weight Result
                          invoke StdOut, ADDR weightResultMsg
                          invoke dwtoa, weight, ADDR weightChoice
                          invoke StdOut, ADDR weightChoice
                          invoke StdOut, ADDR szCrlf


    ; Exit program
                          invoke ExitProcess, 0

end start
