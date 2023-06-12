#SET(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/zg8100_boot_from_ram_link.ld)
set(mains hello_world.s)
generate_bin()