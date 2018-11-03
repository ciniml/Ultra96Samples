set design_name [lindex $argv 0]
set repo_path   [lindex $argv 1]
set target_dir  [lindex $argv 2]
set processor   [lindex $argv 3]

open_hw_design ${design_name}.hdf
set_repo_path [file normalize ${repo_path}]
create_sw_design device-tree -os device_tree -proc ${processor}
set_property CONFIG.dt_overlay true [get_os]
generate_target -dir ${target_dir}
