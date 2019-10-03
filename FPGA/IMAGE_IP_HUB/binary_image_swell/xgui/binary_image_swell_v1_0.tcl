# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "IMG_WIDTH_DATA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IMG_WIDTH_LINE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LINE_N" -parent ${Page_0}


}

proc update_PARAM_VALUE.IMG_WIDTH_DATA { PARAM_VALUE.IMG_WIDTH_DATA } {
	# Procedure called to update IMG_WIDTH_DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMG_WIDTH_DATA { PARAM_VALUE.IMG_WIDTH_DATA } {
	# Procedure called to validate IMG_WIDTH_DATA
	return true
}

proc update_PARAM_VALUE.IMG_WIDTH_LINE { PARAM_VALUE.IMG_WIDTH_LINE } {
	# Procedure called to update IMG_WIDTH_LINE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMG_WIDTH_LINE { PARAM_VALUE.IMG_WIDTH_LINE } {
	# Procedure called to validate IMG_WIDTH_LINE
	return true
}

proc update_PARAM_VALUE.LINE_N { PARAM_VALUE.LINE_N } {
	# Procedure called to update LINE_N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LINE_N { PARAM_VALUE.LINE_N } {
	# Procedure called to validate LINE_N
	return true
}


proc update_MODELPARAM_VALUE.IMG_WIDTH_DATA { MODELPARAM_VALUE.IMG_WIDTH_DATA PARAM_VALUE.IMG_WIDTH_DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMG_WIDTH_DATA}] ${MODELPARAM_VALUE.IMG_WIDTH_DATA}
}

proc update_MODELPARAM_VALUE.IMG_WIDTH_LINE { MODELPARAM_VALUE.IMG_WIDTH_LINE PARAM_VALUE.IMG_WIDTH_LINE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMG_WIDTH_LINE}] ${MODELPARAM_VALUE.IMG_WIDTH_LINE}
}

proc update_MODELPARAM_VALUE.LINE_N { MODELPARAM_VALUE.LINE_N PARAM_VALUE.LINE_N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LINE_N}] ${MODELPARAM_VALUE.LINE_N}
}

