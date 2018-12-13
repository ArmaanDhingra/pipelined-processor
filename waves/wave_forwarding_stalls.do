onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /processor_forwarding_stall/manual_mem_inspect
add wave -noupdate -radix unsigned /processor_forwarding_stall/manual_mem_inspect_addr
add wave -noupdate -radix unsigned /processor_forwarding_stall/init
add wave -noupdate -radix unsigned /processor_forwarding_stall/pc_init_data
add wave -noupdate -color Gold /processor_forwarding_stall/clk
add wave -noupdate /processor_forwarding_stall/clk_cnt
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc_init
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc_init_data
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/clk
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/immediate_extended
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/take_branch
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/stall
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc_plus_4
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/immediate_extended_x4
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc_next
add wave -noupdate -expand -group pc_controller -radix hexadecimal /processor_forwarding_stall/test_comp/pc_control/pc_curr
add wave -noupdate -expand -group {if stage} -radix hexadecimal /processor_forwarding_stall/test_comp/pc
add wave -noupdate -expand -group {if stage} -radix hexadecimal /processor_forwarding_stall/test_comp/instruction
add wave -noupdate -expand -group {if stage} -radix unsigned /processor_forwarding_stall/test_comp/take_branch
add wave -noupdate -expand -group {if stage} -radix unsigned /processor_forwarding_stall/test_comp/stall
add wave -noupdate -group {if/id pipeline} -radix hexadecimal /processor_forwarding_stall/test_comp/pc_if_id
add wave -noupdate -group {if/id pipeline} -radix hexadecimal /processor_forwarding_stall/test_comp/instruction_if_id
add wave -noupdate -group {id/reg stage} -radix binary /processor_forwarding_stall/test_comp/alu_op
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/mem_to_reg
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/reg_wrt
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/mem_wrt
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/branch
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/sign_extend
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/use_imm
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/use_sa
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/rs
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/rt
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/rd
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/reg_bus_a
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/reg_bus_b
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/immediate_extended
add wave -noupdate -group {id/reg stage} -radix unsigned /processor_forwarding_stall/test_comp/shamt_extended
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/reg_bus_a_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/reg_bus_b_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/shamt_extended_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/alu_op_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix hexadecimal /processor_forwarding_stall/test_comp/pc_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix hexadecimal /processor_forwarding_stall/test_comp/instruction_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/mem_to_reg_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/reg_wrt_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/mem_wrt_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/branch_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/sign_extend_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/use_imm_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/use_sa_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/stall_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/immediate_extended_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/rs_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/rt_id_ex
add wave -noupdate -expand -group id_ex_pipeline -radix unsigned /processor_forwarding_stall/test_comp/rd_id_ex
add wave -noupdate -group forwarding -radix unsigned /processor_forwarding_stall/test_comp/alu_a_mem_wb
add wave -noupdate -group forwarding -radix unsigned /processor_forwarding_stall/test_comp/alu_a_valid
add wave -noupdate -group forwarding -radix unsigned /processor_forwarding_stall/test_comp/alu_b_mem_wb
add wave -noupdate -group forwarding -radix unsigned /processor_forwarding_stall/test_comp/alu_b_valid
add wave -noupdate -group forwarding /processor_forwarding_stall/test_comp/forward_rs
add wave -noupdate -group forwarding /processor_forwarding_stall/test_comp/forward_rt
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/test_comp/alu_b_reg_imm
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/test_comp/alu_a
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/test_comp/alu_b
add wave -noupdate -expand -group {ex stage} -radix hexadecimal /processor_forwarding_stall/test_comp/alu_r
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/test_comp/of_flag
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/test_comp/z_flag
add wave -noupdate -expand -group {ex stage} -radix unsigned /processor_forwarding_stall/take_branch
add wave -noupdate -expand -group {ex stage} /processor_forwarding_stall/test_comp/branch_or_load
add wave -noupdate -expand -group {ex stage} /processor_forwarding_stall/test_comp/last_branch_and_stall
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/alu_r_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/reg_bus_b_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/alu_of_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/alu_z_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/mem_to_reg_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/reg_wrt_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/mem_wrt_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/branch_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/sign_extend_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/use_imm_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/use_sa_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/stall_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rs_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rt_ex_mem
add wave -noupdate -group {ex_mem pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rd_ex_mem
add wave -noupdate -group {mem stage} -radix unsigned /processor_forwarding_stall/test_comp/data_mem_read
add wave -noupdate -group {mem stage} -radix hexadecimal /processor_forwarding_stall/test_comp/data_mem_addr
add wave -noupdate -group {mem stage} -radix unsigned /processor_forwarding_stall/test_comp/data_mem_out
add wave -noupdate -group {mem stage} -radix unsigned /processor_forwarding_stall/test_comp/data_mem_wrt
add wave -noupdate -group {mem stage} -radix unsigned /processor_forwarding_stall/data_mem_out
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/alu_r_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/data_mem_out_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/mem_to_reg_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/sign_extend_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/reg_wrt_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/mem_wrt_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/branch_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/use_imm_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/use_sa_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/stall_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rs_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rt_mem_wb
add wave -noupdate -group {mem_wb pipeline} -radix unsigned /processor_forwarding_stall/test_comp/rd_mem_wb
add wave -noupdate -group {wb stage} -radix hexadecimal -childformat {{/processor_forwarding_stall/test_comp/reg_bus_wrt(31) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(30) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(29) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(28) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(27) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(26) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(25) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(24) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(23) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(22) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(21) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(20) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(19) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(18) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(17) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(16) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(15) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(14) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(13) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(12) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(11) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(10) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(9) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(8) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(7) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(6) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(5) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(4) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(3) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(2) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(1) -radix unsigned} {/processor_forwarding_stall/test_comp/reg_bus_wrt(0) -radix unsigned}} -subitemconfig {/processor_forwarding_stall/test_comp/reg_bus_wrt(31) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(30) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(29) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(28) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(27) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(26) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(25) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(24) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(23) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(22) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(21) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(20) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(19) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(18) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(17) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(16) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(15) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(14) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(13) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(12) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(11) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(10) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(9) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(8) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(7) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(6) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(5) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(4) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(3) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(2) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(1) {-height 15 -radix unsigned} /processor_forwarding_stall/test_comp/reg_bus_wrt(0) {-height 15 -radix unsigned}} /processor_forwarding_stall/test_comp/reg_bus_wrt
add wave -noupdate -group stalling /processor_forwarding_stall/test_comp/branch_or_load
add wave -noupdate -group stalling /processor_forwarding_stall/test_comp/last_branch_and_stall
add wave -noupdate -group squashing /processor_forwarding_stall/test_comp/last_inst_branch_or_load
add wave -noupdate -group squashing /processor_forwarding_stall/test_comp/squash
add wave -noupdate -group squashing /processor_forwarding_stall/test_comp/squash_inv
add wave -noupdate -group squashing /processor_forwarding_stall/test_comp/reg_wrt_decoder
add wave -noupdate -group squashing /processor_forwarding_stall/test_comp/mem_wrt_decoder
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6944 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 417
configure wave -valuecolwidth 99
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {34016 ps}
