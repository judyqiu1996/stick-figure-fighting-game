transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib nios_system
vmap nios_system nios_system
vlog -vlog01compat -work nios_system +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/lab8_soc/synthesis/submodules {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/lab8_soc/synthesis/submodules/nios_system_Keycode.v}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/Color_Mapper.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/ball.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/addresshandler.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/ram.sv}
vlog -sv -work work +incdir+C:/Users/zhu_j/Desktop/FPGA/Lab8_usb {C:/Users/zhu_j/Desktop/FPGA/Lab8_usb/lab8.sv}

