#!/bin/bash
source ./main_menu
source ./colours
source ./config_functions
source ./function_calls
source ./function_arrays
source ./hard_variables
source ./pkg_arrays
source ./progress_bar
source ./usr_input_functions
source ./initial_setup_functions

menu_title="Arch Linux Setup Script"
menu_name="Script Configuration"
menu_item="Main Menu"

completed=0
usr=0
toal_num_tasks=$usr_input_tot

total_tasks () {
    for i in "${pkg_tots[@]}" ; do
        total_num_tasks=$((total_num_tasks+$(echo "${i}")))
    done
    total_num_tasks=$((total_num_tasks+${func_tot}))
}
##
## Test run script for menu
##

set_scroll () {
    # Set scrolling region of the screen
#    tput cup $((${header_height})) 0
    tput sc
    tput csr ${header_height} $(($(tput lines)-6))
    tput rc
    tput cud1
}

reset_scroll () {
    # Reset scrolling region of the screen
    tput sc
    tput csr 0 $(tput lines)
    tput rc
}

draw_hdr () {
    clear
    hdr_main_width
    build_header
    draw_header
    set_scroll

}

main_menu () {
    menu_item="Main Menu"
    draw_hdr
    draw_prog_bars "Script Configuration" ${usr}  ${usr_input_tot} ${completed} ${total_num_tasks}
    setup_menu
    setup_select

}

sys_prep
total_tasks
main_menu
