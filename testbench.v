`timescale 1ns / 1ps

module pipelined_processor_tb;

    reg clk;
    reg reset;

    pipelined_processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulation
    initial begin
        reset = 1;
        #10;
        reset = 0;

        #100; // Let instructions pass through pipeline

        $finish;
    end

    // Watch register values
    integer i;
    always @(posedge clk) begin
        $display("Time = %0t", $time);
        for (i = 0; i < 6; i = i + 1)
            $display("R[%0d] = %0d", i, uut.reg_file[i]);
        $display("PC = %0d\n", uut.PC);
    end

endmodule
