if { [llength $argv] == 0 } {
    error "Project name must be specified."
}
if { [llength $argv] == 1 } {
    error "Top level function name must be specified."
}

set project_name [lindex $argv 0]
set top_name [lindex $argv 1]
set solution_name {solution1}
set device_part {xczu3eg-sbva484-1-e}

open_project ${project_name}
set_top ${top_name}
add_files ${project_name}.cpp
add_files ${project_name}.hpp
add_files -tb test_${project_name}.cpp

open_solution ${solution_name}
set_part ${device_part}
create_clock -period 10 -name default
