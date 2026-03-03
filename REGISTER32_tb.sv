`timescale 1ns/1ps

module REGISTER32_tb;

    reg clk;
    reg rst;
    reg write_en;
    reg [3:0] rd;
    reg [3:0] rs;
    reg [3:0] rt;
    reg [31:0] data_in;

    wire [31:0] rs_data_out;
    wire [31:0] rt_data_out;
    wire [7:0]  r15;

    // Instantiate DUT
    REGISTER32 reg32 (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .rd(rd),
        .data_in(data_in),
        .rs(rs),
        .rs_data_out(rs_data_out),
        .rt(rt),
        .rt_data_out(rt_data_out),
        .r15(r15)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $display("==== REGISTER FILE TEST START ====");

        clk = 0;
        rst = 1;
        write_en = 0;
        rd = 0;
        rs = 0;
        rt = 0;
        data_in = 0;

        #10;

        // ============================
        // RESET TEST (Active LOW)
        // ============================
//        $display("---- RESET PHASE ----");
//        rst = 0;        // activate reset
//        #10;
//        rst = 1;        // release reset
//        #10;
//
//        // Check initial values
//        rs = 4'd1;
//        rt = 4'd2;
//        #5;
//        $display("After reset: R1=%d  R2=%d", rs_data_out, rt_data_out);

        // ============================
        // WRITE TEST
        // ============================
        $display("---- WRITE TEST ----");

        write_en = 1;
        rd = 4'd5;
        data_in = 32'd1998;
        #10;

        write_en = 0;

        // Read back
        rs = 4'd5;
        #5;
        $display("R5 after write = %h", rs_data_out);

        // ============================
        // REGISTER 0 PROTECTION TEST
        // ============================
//        $display("---- REGISTER 0 TEST ----");
//
//        write_en = 1;
//        rd = 4'd0;
//        data_in = 32'hFFFFFFFF;
//        #10;
//
//        write_en = 0;
//        rs = 4'd0;
//        #5;
//        $display("R0 (should be 0) = %h", rs_data_out);

        // ============================
        // READ PORT 2 TEST
        // ============================
//        $display("---- DUAL READ TEST ----");
//
//        write_en = 1;
//        rd = 4'd10;
//        data_in = 32'h12345678;
//        #10;
//
//        write_en = 0;
//        rs = 4'd5;
//        rt = 4'd10;
//        #5;
//        $display("R5=%h  R10=%h", rs_data_out, rt_data_out);

        // ============================
        // R15 OUTPUT TEST
        // ============================
        $display("---- R15 OUTPUT TEST ----");

        rs = 4'd15;
        #5;
        $display("R15 full = %h  | r15 (LSB 8-bit) = %h",
                  rs_data_out, r15);

        $display("==== REGISTER FILE TEST END ====");
        $stop;
    end

endmodule
