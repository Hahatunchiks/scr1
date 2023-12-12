module scr1_tb_log_cmd (
    input logic [`SCR1_XLEN-1:0] csr_mstatus_local,
    input logic [`SCR1_XLEN-1:0] csr_mtvec_local,
    input logic [SCR1_CSR_COUNTERS_WIDTH-1:0] csr_mcycle_local,
    input logic [`SCR1_XLEN-1:0] pc_local
);

  always_ff @(posedge scr1_top_tb_ahb.i_top.i_imem_ahb.clk) begin
    // valid data from ahb router
    if (
        (scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_ifu.ifu2idu_instr_o[6 : 0] == 7'b0110011) &
        (scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_ifu.ifu2idu_instr_o[14 : 12] == 3'b000) &
        (scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_ifu.ifu2idu_instr_o[31 : 25] == 7'b0100000 )
    ) begin
      // detect sub command
      $display("Detect SUB command, CSR values is:");
      $display("mstatus=0x%0h", csr_mstatus_local);
      $display("mtvec=0x%0h", csr_mtvec_local);
      $display("mcycle=0x%0h", csr_mcycle_local);
      // additional, check that this trace and tracelog are same
      $display("pc=0x%0h", pc_local);
    end
  end

endmodule
