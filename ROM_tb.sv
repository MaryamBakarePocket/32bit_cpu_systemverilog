`timescale 1ns/1ps

module ROM_tb;

    // Testbench signals
    reg  [31:0] addr;
    reg         OE;
    wire [31:0] data_out;

    // Instantiate the ROM
    ROM imem(
        .addr(addr),
        .OE(OE),
        .data_out(data_out)
    );

    integer i;

    initial begin
        $display("==== ROM TEST START ====");
        $display("Time\tOE\tAddress\t\tData Out");
        $display("%0t\t%b\t%h\t%h", $time, OE, addr, data_out);

        // Enable output
        OE = 1;

        // ==========================
        // Test PROGRAM 1 (0 – 18)
        // ==========================
        $display("\n--- Testing PROGRAM 1 ---");
        //for (i = 0; i <= 18; i = i + 1) begin
            addr = 5;     // quad-byte addressing assumed
            #10;
        //end

        // ==========================
        // Test PROGRAM 2 (20 – 29)
        // ==========================
//        $display("\n--- Testing PROGRAM 2 ---");
//        for (i = 20; i <= 29; i = i + 1) begin
//            addr = i;
//            #10;
//        end

//        // Disable output
//        OE = 0;
//        addr = 0;
//        #10;
//
//        $display("==== ROM TEST END ====");
        $stop;
    end

endmodule
