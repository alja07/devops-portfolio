#!/bin/bash

color1=${col1_color_bg:-6} # черный фон по умолчанию
color2=${col1_color_font:-1} # белый текст по умолчанию
color3=${col2_color_bg:-2} # красный фон по умолчанию
color4=${col2_color_font:-4} # синий текст по умолчанию

white_bg="\033[47m"
red_bg="\033[41m"
green_bg="\033[42m"
blue_bg="\033[44m"
purple_bg="\033[45m"
black_bg="\033[40m"

reset_color="\e[0m"

white_font="\033[37m"
red_font="\033[0;31m"
green_font="\033[0;32m"
blue_font="\033[0;34m" 
purple_font="\033[0;35m"
black_font="\033[0;30m"