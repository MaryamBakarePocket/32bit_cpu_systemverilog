`timescale 1ns/1ps

module RAM_tb;

    reg         clk;
    reg         CS;
    reg         RW_;              // 1 = Read, 0 = Write
    reg  [31:0] addr;
    reg  [31:0] data_in;
    wire [31:0] data_out;

    // Instantiate RAM
    RAM dmem(
        .clk(clk),
        .CS(CS),
        .RW_(RW_),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $display("==== RAM TEST START ====");

        clk = 0;
        CS = 0;
        RW_ = 1;
        addr = 0;
        data_in = 0;

        #10;

        // =============================
        // WRITE PHASE
        // =============================
//        $display("---- WRITE PHASE ----");
//
        CS = 1;
        RW_ = 0;                      // Write mode

        // Write first word
        addr = 0;
        data_in = 32'hAABBCCDD;
        #10;                          // wait one clock

        // Write second word
        addr = 2;
        data_in = 32'h11223344;
        #10;

        // =============================
        // READ PHASE
        // =============================
        $display("---- READ PHASE ----");

        RW_ = 1;                      // Read mode
		  CS = 1;
        addr = 0;
		  
        #10;
        $display("Read @0  = %d", data_out);
			
		//To read addr2, do this;
//        addr = 2;
//        #10;
//        $display("Read @2  = %d", data_out);

        // =============================
        // CHIP DISABLE TEST
        // =============================
//        $display("---- CHIP DISABLE TEST ----");
//
//        CS = 0;
//        addr = 0;
//        #10;
//        $display("With CS=0, Data_out = %h", data_out);
//
//        $display("==== RAM TEST END ====");
        $stop;
    end

endmodule
