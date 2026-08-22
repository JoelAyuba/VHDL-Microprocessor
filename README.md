# VHDL Microprocessor: Shopping Basket Cost Calculator

## Executive Summary
This project features the design, implementation, and simulation of a VHDL-based microprocessor unit. Its primary function is to compute the total and average cost of items in a shopping basket. The system evolved from a basic Arithmetic Logic Unit (ALU) into an autonomous Harvard-architecture microprocessor capable of fetching instructions and data, computing values, and storing results independently.

## Architecture and Design
The microprocessor utilizes a Harvard-style architecture, meaning instruction and data memory are separated. The design operates on a 100 MHz clock and uses 32-bit data types to prevent data misrepresentation during average calculations.

### Key Components
* **Top-Level Controller (`top-level`)**: Centers around a Program Counter (`program`) that increments every clock cycle, replacing manual switch toggling and automating execution.
* **Arithmetic Logic Unit (`alu`)**: The computational engine performing addition, subtraction, bitwise logic, and bit shifting.
* **Instruction Memory (`instructions`)**: Delivers 16-bit instructions (4-bit opcode, 4-bit destination address, 8-bit data addresses) to the processor.
* **Data Memory (`rom`)**: Stores the shopping basket data in a 32-bit hexadecimal format (values in pence).
* **Testbench (`tb`)**: Initializes the 100 MHz clock and contains a wait command to allow uninterrupted program completion.

## ALU Instruction Set
The ALU executes unique opcodes for corresponding mathematical operations. Key operations utilized in this project include:
* `10`: Addition (`num1 + num2`)
* `11`: Shift right arithmetic
*(Other implemented operations include subtraction, AND, OR, XOR, and logical shifts).*

## Calculation Process and Simulation Results
The behavioral simulation was conducted using Vivado software.

1. **Total Calculation**: The program iterates through addresses 1 to 8, fetching 8 item values from ROM (e.g., 600, -1500, 1800, 2200, 2400, -2600, 2700, 1900). Using the addition opcode (`10`), it sums the values to reach a total of 7500 pence (Hex: `00001D4C`).
2. **Average Calculation**: To find the average across 8 items, the system utilizes the shift right arithmetic opcode (`11`) three consecutive times on the total sum. This effectively divides the total by 8, yielding an average of 937 (Hex: `000003A9`).

## Evaluation
### Strengths
* **Autonomy**: Successful enhancement from a manual, switch-based system to an automated instruction execution system.
* **Accuracy**: Extended to a 32-bit signed architecture, preventing fractional truncation issues present in the initial 8-bit design.
* **Depth**: Computes both the cumulative total and the average, providing a deeper layer of analytical capability.

### Limitations
* **Integer Truncation**: Due to integer arithmetic, remainders are truncated during bit-shifting (e.g., the exact average of 937.5 is truncated to 937), which limits financial accuracy.
* **Strict Sequential Execution**: The program counter only increments by 1; the lack of a 'jump' instruction means the system must sequentially step through the entire program, slowing down operations for larger datasets.

### Future Improvements
* **Floating-Point Support**: Implementing floating-point arithmetic or a remainder register to store omitted information from bit-shifts.
* **Jump Instructions**: Adding branching capabilities to allow the program to move between specific iterations without restarting, drastically improving efficiency for large datasets.
