`timescale 1ns / 1ps

module toplevel(
    input   clk,
    input   P4_2,
    input   P4_1,
    output  P4_3,
    input   P4_4,
    output  TX,
    input   RX,
    output [7:0] io_led
  );
  
  wire [31:0] io_gpioA_read;
  wire [31:0] io_gpioA_write;
  wire [31:0] io_gpioA_writeEnable;
  wire io_mainClk;
  wire io_jtag_tck;

  SB_GB mainClkBuffer (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (clk),
    .GLOBAL_BUFFER_OUTPUT ( io_mainClk)
  );

  SB_GB jtagClkBuffer (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (P4_2),
    .GLOBAL_BUFFER_OUTPUT ( io_jtag_tck)
  );

  assign io_led = io_gpioA_write[7 : 0];

  Murax murax ( 
    .io_asyncReset(0),
    .io_mainClk (io_mainClk ),
    .io_jtag_tck(io_jtag_tck),
    .io_jtag_tdi(P4_1),
    .io_jtag_tdo(P4_3),
    .io_jtag_tms(P4_4),
    .io_gpioA_read       (io_gpioA_read),
    .io_gpioA_write      (io_gpioA_write),
    .io_gpioA_writeEnable(io_gpioA_writeEnable),
    .io_uart_txd(TX),
    .io_uart_rxd(RX)
  );		
endmodule
