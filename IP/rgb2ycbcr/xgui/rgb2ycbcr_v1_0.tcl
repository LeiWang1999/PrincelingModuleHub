# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "para_0040_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0062_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0101_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0183_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0338_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0399_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0439_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_0614_10b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_128_18b" -parent ${Page_0}
  ipgui::add_param $IPINST -name "para_16_18b" -parent ${Page_0}


}

proc update_PARAM_VALUE.para_0040_10b { PARAM_VALUE.para_0040_10b } {
	# Procedure called to update para_0040_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0040_10b { PARAM_VALUE.para_0040_10b } {
	# Procedure called to validate para_0040_10b
	return true
}

proc update_PARAM_VALUE.para_0062_10b { PARAM_VALUE.para_0062_10b } {
	# Procedure called to update para_0062_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0062_10b { PARAM_VALUE.para_0062_10b } {
	# Procedure called to validate para_0062_10b
	return true
}

proc update_PARAM_VALUE.para_0101_10b { PARAM_VALUE.para_0101_10b } {
	# Procedure called to update para_0101_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0101_10b { PARAM_VALUE.para_0101_10b } {
	# Procedure called to validate para_0101_10b
	return true
}

proc update_PARAM_VALUE.para_0183_10b { PARAM_VALUE.para_0183_10b } {
	# Procedure called to update para_0183_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0183_10b { PARAM_VALUE.para_0183_10b } {
	# Procedure called to validate para_0183_10b
	return true
}

proc update_PARAM_VALUE.para_0338_10b { PARAM_VALUE.para_0338_10b } {
	# Procedure called to update para_0338_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0338_10b { PARAM_VALUE.para_0338_10b } {
	# Procedure called to validate para_0338_10b
	return true
}

proc update_PARAM_VALUE.para_0399_10b { PARAM_VALUE.para_0399_10b } {
	# Procedure called to update para_0399_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0399_10b { PARAM_VALUE.para_0399_10b } {
	# Procedure called to validate para_0399_10b
	return true
}

proc update_PARAM_VALUE.para_0439_10b { PARAM_VALUE.para_0439_10b } {
	# Procedure called to update para_0439_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0439_10b { PARAM_VALUE.para_0439_10b } {
	# Procedure called to validate para_0439_10b
	return true
}

proc update_PARAM_VALUE.para_0614_10b { PARAM_VALUE.para_0614_10b } {
	# Procedure called to update para_0614_10b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_0614_10b { PARAM_VALUE.para_0614_10b } {
	# Procedure called to validate para_0614_10b
	return true
}

proc update_PARAM_VALUE.para_128_18b { PARAM_VALUE.para_128_18b } {
	# Procedure called to update para_128_18b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_128_18b { PARAM_VALUE.para_128_18b } {
	# Procedure called to validate para_128_18b
	return true
}

proc update_PARAM_VALUE.para_16_18b { PARAM_VALUE.para_16_18b } {
	# Procedure called to update para_16_18b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.para_16_18b { PARAM_VALUE.para_16_18b } {
	# Procedure called to validate para_16_18b
	return true
}


proc update_MODELPARAM_VALUE.para_0183_10b { MODELPARAM_VALUE.para_0183_10b PARAM_VALUE.para_0183_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0183_10b}] ${MODELPARAM_VALUE.para_0183_10b}
}

proc update_MODELPARAM_VALUE.para_0614_10b { MODELPARAM_VALUE.para_0614_10b PARAM_VALUE.para_0614_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0614_10b}] ${MODELPARAM_VALUE.para_0614_10b}
}

proc update_MODELPARAM_VALUE.para_0062_10b { MODELPARAM_VALUE.para_0062_10b PARAM_VALUE.para_0062_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0062_10b}] ${MODELPARAM_VALUE.para_0062_10b}
}

proc update_MODELPARAM_VALUE.para_0101_10b { MODELPARAM_VALUE.para_0101_10b PARAM_VALUE.para_0101_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0101_10b}] ${MODELPARAM_VALUE.para_0101_10b}
}

proc update_MODELPARAM_VALUE.para_0338_10b { MODELPARAM_VALUE.para_0338_10b PARAM_VALUE.para_0338_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0338_10b}] ${MODELPARAM_VALUE.para_0338_10b}
}

proc update_MODELPARAM_VALUE.para_0439_10b { MODELPARAM_VALUE.para_0439_10b PARAM_VALUE.para_0439_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0439_10b}] ${MODELPARAM_VALUE.para_0439_10b}
}

proc update_MODELPARAM_VALUE.para_0399_10b { MODELPARAM_VALUE.para_0399_10b PARAM_VALUE.para_0399_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0399_10b}] ${MODELPARAM_VALUE.para_0399_10b}
}

proc update_MODELPARAM_VALUE.para_0040_10b { MODELPARAM_VALUE.para_0040_10b PARAM_VALUE.para_0040_10b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_0040_10b}] ${MODELPARAM_VALUE.para_0040_10b}
}

proc update_MODELPARAM_VALUE.para_16_18b { MODELPARAM_VALUE.para_16_18b PARAM_VALUE.para_16_18b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_16_18b}] ${MODELPARAM_VALUE.para_16_18b}
}

proc update_MODELPARAM_VALUE.para_128_18b { MODELPARAM_VALUE.para_128_18b PARAM_VALUE.para_128_18b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.para_128_18b}] ${MODELPARAM_VALUE.para_128_18b}
}

