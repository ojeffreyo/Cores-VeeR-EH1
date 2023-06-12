#SET(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/zg8100_boot_from_ram_link.ld)
set(mains cmark_dccm.c)
generate_bin()