module pipelined_processor (
    input clk,
    input reset
);

    // ========== Memories and Registers ==========
    reg [15:0] instr_mem [0:15];    // Instruction Memory
    reg [7:0] data_mem  [0:15];     // Data Memory
    reg [7:0] reg_file  [0:15];     // Register File
    reg [7:0] PC;                   // Program Counter

    // ========== Pipeline Registers ==========
    reg [15:0] IF_ID;
    reg [15:0] ID_EX;
    reg [15:0] EX_WB;
    reg [7:0]  alu_result;

    // ========== IF Stage ==========
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;
            IF_ID <= 0;
        end else begin
            IF_ID <= instr_mem[PC];
            PC <= PC + 1;
        end
    end

    // ========== ID Stage ==========
    always @(posedge clk or posedge reset) begin
        if (reset)
            ID_EX <= 0;
        else
            ID_EX <= IF_ID;
    end

    // ========== EX Stage ==========
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_result <= 0;
            EX_WB <= 0;
        end else begin
            EX_WB <= ID_EX;
            case (ID_EX[15:12])  // Opcode
                4'b0000: alu_result <= reg_file[ID_EX[7:4]] + reg_file[ID_EX[3:0]];  // ADD
                4'b0001: alu_result <= reg_file[ID_EX[7:4]] - reg_file[ID_EX[3:0]];  // SUB
                4'b0010: alu_result <= data_mem[ID_EX[3:0]];                         // LOAD
                default: alu_result <= 0;
            endcase
        end
    end

    // ========== WB Stage ==========
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // clear all regs
            reg_file[0] <= 0;
        end else begin
            case (EX_WB[15:12])
                4'b0000, 4'b0001, 4'b0010: reg_file[EX_WB[11:8]] <= alu_result;
            endcase
        end
    end

    // ========== Initialization (Simulation Only) ==========
    initial begin
        // Program:
        // R2 = 10, R3 = 20
        // ADD R1 = R2 + R3 => 30
        // SUB R4 = R1 - R2 => 20
        // LOAD R5 = MEM[2] => 55
        reg_file[2] = 10;
        reg_file[3] = 20;
        data_mem[2] = 55;

        instr_mem[0] = {4'b0000, 4'd1, 4'd2, 4'd3}; // ADD R1 = R2 + R3
        instr_mem[1] = {4'b0001, 4'd4, 4'd3, 4'd2}; // SUB R4 = R3 - R2
        instr_mem[2] = {4'b0010, 4'd5, 4'd0, 4'd2}; // LOAD R5 = MEM[2]
    end

endmodule
