if { [llength $argv] == 0 } {
    error "Project name must be specified."
}

set project_name [lindex $argv 0]

open_project $project_name

update_compile_order -fileset sources_1
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

file mkdir $project_name.sdk
file copy -force $project_name.runs/impl_1/design_top_wrapper.sysdef $project_name.sdk/design_top_wrapper.hdf
