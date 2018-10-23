if { [llength $argv] == 0 } {
    error "Project name must be specified."
}

set project_name [lindex $argv 0]
set board_part {em.avnet.com:ultra96v2:part0:1.0}
set device_part {xczu3eg-sbva484-1-e}

create_project -part $device_part $project_name .
set_property BOARD_PART $board_part [current_project]

add_files -fileset [get_filesets sources_1] ./blink.v
add_files -fileset [get_filesets constrs_1] ./Ultra96_constraints_180318.xdc

source ./design_top.tcl
make_wrapper -top -fileset sources_1 -import [get_files $project_name.srcs/sources_1/bd/design_top/design_top.bd]

