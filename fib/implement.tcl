if { [llength $argv] == 0 } {
    error "Project name must be specified."
}
set project_name [lindex $argv 0]
set solution_name {solution1}

open_project ${project_name}
open_solution ${solution_name}

csynth_design
export_design -format ip_catalog
