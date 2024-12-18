# Calorie/TDEE Calculator

## Project Overview

This project is an Assembly language implementation of a Calorie and Total Daily Energy Expenditure (TDEE) Calculator. Inspired by the functionality of [Calculator.net's Calorie Calculator](https://www.calculator.net/calorie-calculator.html), our program allows users to estimate their daily caloric needs based on their personal information and activity level.

## Features

- Calculate Basal Metabolic Rate (BMR) using the Mifflin-St Jeor Equation.
- Adjust caloric needs based on the user's activity level.
- Provide maintenance calories and estimates for weight loss or gain goals.

## Team Members

- Niles Vincent Gabrielle Rondez
- Jude Mahilum Ando
- James Matthew Creer Garcia

## Requirements

- Assembly language assembler (e.g., NASM, MASM, or similar).
- 32-bit or 64-bit x86 architecture support.
- Basic command-line interface for user input.

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd assembly-tdee-calculator
   ```
3. Assemble and link the program (example for NASM):
   ```bash
   nasm -f elf64 calculator.asm -o calculator.o
   ld calculator.o -o calculator
   ```

## Usage

1. Run the program:
   ```bash
   ./calculator
   ```
2. Follow the prompts to input the required details:
   - Age
   - Gender
   - Height (in cm)
   - Weight (in kg)
   - Activity level (e.g., sedentary, lightly active, active, very active)
3. View your results, including:
   - BMR
   - Maintenance calories
   - Calories for weight loss or gain.

## Formulae Used

### BMR: Mifflin-St Jeor Equation

- **For men**: `BMR = 10 * weight (kg) + 6.25 * height (cm) - 5 * age (years) + 5`
- **For women**: `BMR = 10 * weight (kg) + 6.25 * height (cm) - 5 * age (years) - 161`

### TDEE Calculation

TDEE = BMR \* Activity Multiplier

- Sedentary (little or no exercise): 1.2
- Lightly active (light exercise/sports 1-3 days a week): 1.375
- Moderately active (moderate exercise/sports 3-5 days a week): 1.55
- Very active (hard exercise/sports 6-7 days a week): 1.725
- Extra active (very hard exercise or physical job): 1.9

## Acknowledgments

This project is inspired by the [Calculator.net Calorie Calculator](https://www.calculator.net/calorie-calculator.html) and serves as a practical exercise in Assembly language programming.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
