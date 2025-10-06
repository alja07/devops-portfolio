#!/bin/bash

source vars.sh

source check_input.sh 
check_input "$@"
check_input_color "$@"

source colors.sh
source cases.sh

source output_color_info.sh

source output_file.sh
output_file

exit 0