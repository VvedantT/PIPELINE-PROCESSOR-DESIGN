# PIPELINE-PROCESSOR-DESIGN

*COMPANY *  :CODTECH IT SOLUTIONS
*NAME*      :VEDANT DARJI
*INTERN ID* :CT08DN1242
*DOMAIN*    :VLSI
*DURATION*  :8 WEEKS
*MENTOR*    :NEELA SANTOSH

A 4-STAGE PIPELINED PROCESSOR WITH BASIC INSTRUCTIONS LIKE ADD, SUB, AND LOAD.
This processor simulates a simple RISC-style pipelined CPU that executes three basic instructions — ADD, SUB, and LOAD — across four pipeline stages:

Pipeline Stages
IF (Instruction Fetch)
  Fetches the instruction from instruction memory using the program counter (PC).
  Stores it in the IF_ID pipeline register for the next stage.
  
ID (Instruction Decode & Register Read)
  Decodes opcode and operands.
  Passes instruction to the next stage via ID_EX.

EX (Execute or Memory Access)
  Performs computation using the ALU (ADD or SUB), or fetches data from memory for LOAD.
  Result is stored in alu_result.
  Instruction is passed to EX_WB.

WB (Write Back)
  Writes result back to the register file based on instruction type.
  
| Stage | Name               | Description                         |
| ----- | ------------------ | ----------------------------------- |
| IF    | Instruction Fetch  | Fetch instruction from memory       |
| ID    | Instruction Decode | Decode instruction & read registers |
| EX    | Execute            | ALU or memory access                |
| WB    | Write Back         | Write result to register file       |

In the module.v code I have initialize certain data such as reg_file[2]=10 and reg_file[3]=20 and data_mem=55 and I am feeding these as inputs with their perticular opcodes coressponding to ADD,SUB,LOAD.

|FUNCTION |OPCODE |
|---------|-------|
|ADD      |4'b0000|
|SUB      |4'b0001|
|LOAD     |4'b0010|

Therefore i am initializing program counter(PC) to 0 and incrementing it by 1.
If reset is equal to 1 the PC is made 0 

Inside the testbench i am just calling the clk and reset and displaying all the register values on the TCL console.

<img width="1617" height="860" alt="Image" src="https://github.com/user-attachments/assets/78724fae-8ba8-445f-b876-4be06a396a7d" />
<img width="1622" height="868" alt="Image" src="https://github.com/user-attachments/assets/eccea850-6d95-4e08-ac57-53a7ec8ca193" />

<img width="1419" height="588" alt="Image" src="https://github.com/user-attachments/assets/0036d64e-9978-477d-98e8-3e15e4fc6958" />

