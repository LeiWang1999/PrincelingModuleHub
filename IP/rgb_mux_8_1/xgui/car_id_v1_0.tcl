# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CB_HIGH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CB_LOW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CR_HIGH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CR_LOW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Y_HIGH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Y_LOW" -parent ${Page_0}


}

proc update_PARAM_VALUE.CB_HIGH { PARAM_VALUE.CB_HIGH } {
	# Procedure called to update CB_HIGH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CB_HIGH { PARAM_VALUE.CB_HIGH } {
	# Procedure called to validate CB_HIGH
	return true
}

proc update_PARAM_VALUE.CB_LOW { PARAM_VALUE.CB_LOW } {
	# Procedure called to update CB_LOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CB_LOW { PARAM_VALUE.CB_LOW } {
	# Procedure called to validate CB_LOW
	return true
}

proc update_PARAM_VALUE.CR_HIGH { PARAM_VALUE.CR_HIGH } {
	# Procedure called to update CR_HIGH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CR_HIGH { PARAM_VALUE.CR_HIGH } {
	# Procedure called to validate CR_HIGH
	return true
}

proc update_PARAM_VALUE.CR_LOW { PARAM_VALUE.CR_LOW } {
	# Procedure called to update CR_LOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CR_LOW { PARAM_VALUE.CR_LOW } {
	# Procedure called to validate CR_LOW
	return true
}

proc update_PARAM_VALUE.Y_HIGH { PARAM_VALUE.Y_HIGH } {
	# Procedure called to update Y_HIGH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Y_HIGH { PARAM_VALUE.Y_HIGH } {
	# Procedure called to validate Y_HIGH
	return true
}

proc update_PARAM_VALUE.Y_LOW { PARAM_VALUE.Y_LOW } {
	# Procedure called to update Y_LOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Y_LOW { PARAM_VALUE.Y_LOW } {
	# Procedure called to validate Y_LOW
	return true
}


proc update_MODELPARAM_VALUE.Y_LOW { MODELPARAM_VALUE.Y_LOW PARAM_VALUE.Y_LOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Y_LOW}] ${MODELPARAM_VALUE.Y_LOW}
}

proc update_MODELPARAM_VALUE.Y_HIGH { MODELPARAM_VALUE.Y_HIGH PARAM_VALUE.Y_HIGH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Y_HIGH}] ${MODELPARAM_VALUE.Y_HIGH}
}

proc update_MODELPARAM_VALUE.CB_LOW { MODELPARAM_VALUE.CB_LOW PARAM_VALUE.CB_LOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CB_LOW}] ${MODELPARAM_VALUE.CB_LOW}
}

proc update_MODELPARAM_VALUE.CB_HIGH { MODELPARAM_VALUE.CB_HIGH PARAM_VALUE.CB_HIGH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CB_HIGH}] ${MODELPARAM_VALUE.CB_HIGH}
}

proc update_MODELPARAM_VALUE.CR_LOW { MODELPARAM_VALUE.CR_LOW PARAM_VALUE.CR_LOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CR_LOW}] ${MODELPARAM_VALUE.CR_LOW}
}

proc update_MODELPARAM_VALUE.CR_HIGH { MODELPARAM_VALUE.CR_HIGH PARAM_VALUE.CR_HIGH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CR_HIGH}] ${MODELPARAM_VALUE.CR_HIGH}
}

