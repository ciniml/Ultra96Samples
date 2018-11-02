set target_os [lindex $argv 0]
set target_processor [lindex $argv 0]
set target_app [lindex $argv 0]
set app_dir_name [lindex $argv 0]

set project_name [file tail [pwd]]
set design_name {design_top_wrapper}
set sdk_dir ${project_name}.sdk
set app_dir [file join ${sdk_dir} ${app_dir_name}]
puts [pwd]
puts ${sdk_dir}
puts ${design_name}
set hw_design [open_hw_design [file normalize [file join [pwd] ${sdk_dir} ${design_name}.hdf]]]

generate_app -hw ${hw_design} -os ${target_os} -proc ${target_processor} -app ${target_app} -compile -dir ${app_dir}
