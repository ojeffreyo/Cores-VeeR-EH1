#!/bin/bash
#Time:2021-04-13 15:14:03
#Name:env.sh
#Version:V1.0
#Description: This is a script.

export SDKTOPDIR=$PWD
echo set $SDKTOPDIR as TOPDIR

# HOST=$(uname -n)
# if [ "$HOST" = zg6 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg1 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg2 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg3 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg4 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg5 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = zg7 ]; then
# export PATH="$PATH:/home/yshen/work/putuo/vendor/lowrisc-toolchain-gcc-rv32imc-20200904-1/bin/"
# elif [ "$HOST" = accelor-pro ]; then
# export PATH="$PATH:/opt/riscv/bin/"
# else 
export CROSS=riscv64-unknown-elf-
# fi
# export PATH=$PATH:/home/fyu/fopt/Xilinx/SDK/2018.3/tps/lnx64/cmake-3.3.2/bin/
# export PATH=$PATH:/home/fyu/fopt/ninja/
echo set $HOST CROSS
