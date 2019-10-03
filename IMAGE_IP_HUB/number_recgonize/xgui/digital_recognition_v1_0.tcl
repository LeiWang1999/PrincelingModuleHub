# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "P_1_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "P_2_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "P_2_5" -parent ${Page_0}
  ipgui::add_param $IPINST -name "P_3_5" -parent ${Page_0}


}

proc update_PARAM_VALUE.P_1_3 { PARAM_VALUE.P_1_3 } {
	# Procedure called to update P_1_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.P_1_3 { PARAM_VALUE.P_1_3 } {
	# Procedure called to validate P_1_3
	return true
}

proc update_PARAM_VALUE.P_2_3 { PARAM_VALUE.P_2_3 } {
	# Procedure called to update P_2_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.P_2_3 { PARAM_VALUE.P_2_3 } {
	# Procedure called to validate P_2_3
	return true
}

proc update_PARAM_VALUE.P_2_5 { PARAM_VALUE.P_2_5 } {
	# Procedure called to update P_2_5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.P_2_5 { PARAM_VALUE.P_2_5 } {
	# Procedure called to validate P_2_5
	return true
}

proc update_PARAM_VALUE.P_3_5 { PARAM_VALUE.P_3_5 } {
	# Procedure called to update P_3_5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.P_3_5 { PARAM_VALUE.P_3_5 } {
	# Procedure called to validate P_3_5
	return true
}


proc update_MODELPARAM_VALUE.P_1_3 { MODELPARAM_VALUE.P_1_3 PARAM_VALUE.P_1_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.P_1_3}] ${MODELPARAM_VALUE.P_1_3}
}

proc update_MODELPARAM_VALUE.P_2_3 { MODELPARAM_VALUE.P_2_3 PARAM_VALUE.P_2_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.P_2_3}] ${MODELPARAM_VALUE.P_2_3}
}

proc update_MODELPARAM_VALUE.P_2_5 { MODELPARAM_VALUE.P_2_5 PARAM_VALUE.P_2_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.P_2_5}] ${MODELPARAM_VALUE.P_2_5}
}

proc update_MODELPARAM_VALUE.P_3_5 { MODELPARAM_VALUE.P_3_5 PARAM_VALUE.P_3_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.P_3_5}] ${MODELPARAM_VALUE.P_3_5}
}

