`timescale 1ns / 1ps

module testbench;
    reg clk; //test clock
    reg rst; //test reset


//instantiate cpu
    cpu dut(.clk(clk), .rst(rst));

//clock genreation: 100MHz clock
    always #5 clk = ~clk;

//test sequence
    initial begin
      //init signals
        clk = 0;
        rst = 1;

//create waveform file for debugging
        $dumpfile("sim/tb.vcd");
        $dumpvars(0, testbench);

        $display("*** RISC-V CPU Testbench Starting ***");


//apply reset
        #20;
        rst = 0;
        $display("Reset released");


//run simulation for enough cucles to complete test prog.
        #500;


//display final results
        $display("\n** Simulation Results **");
        $display("Final PC: 0x%h", dut.pc);

        $display("\nSimulation completed");
        $finish;
    end


//monitor important signals for each clock cycle
    always @(posedge clk) begin
        if (!rst) begin
            $display("Cycle %0d: PC=0x%h", $time/10, dut.pc);
        end
    end

endmodule
