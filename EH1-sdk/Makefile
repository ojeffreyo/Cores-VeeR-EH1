APP?=01_hello
BOARD?=genesys2-fpga
RTOS?=none
CROSS?=riscv64-unknown-elf-
MAKEALL = make all
MAKECLEAN = make clean
# TARGETNAME$(NUM) = $(shell ls -1 example | sed -n '$(NUM),$(NUM)p')
# ALLTARGETNAME = $(shell ls example)
TOPDIR = $(shell pwd)
#TOPDIR = $(SDKTOPDIR)
OUTDIR = $(TOPDIR)/output
#HALTADDR = $(shell $(CROSS)readelf -s $(OUTDIR)/$(APP)/$(APP).elf | grep abort | sed -e "s/.*\(08\w\+\).*/\1/")
export APP
export BOARD
export RTOS
export HALTADDR
.PHONY : build

# bootrom:
# 	@$(MAKECLEAN) -C  firmware/bootrom
# 	@$(MAKEALL) -C  firmware/bootrom

# build_eclipse_make:
# 	cmake -E make_directory build.eclipse
# 	cd build.eclipse && cmake .. -G"Eclipse CDT4 - Unix Makefiles" -DAPP=$(APP) -DBOARD=$(BOARD) -DRTOS=$(RTOS)
# 	make -C build.eclipse -j8

# defult use ninja as the build system
# build_eclipse:
# 	cmake -E make_directory build.eclipse
# 	cd build.eclipse && cmake .. -G"Eclipse CDT4 - Ninja" -DAPP=$(APP) -DBOARD=$(BOARD) -DRTOS=$(RTOS)
# 	ninja -C build.eclipse -j8


build_make:
	rm -rf build.make
	cmake -E make_directory build.make
	cd build.make && cmake .. -G"Unix Makefiles" -DAPP=$(APP) -DBOARD=$(BOARD) -DRTOS=$(RTOS)
	make -C build.make -j8
	@make vmem

# defult use ninja as the build system
build:
	cmake -E make_directory build.ninja
	cd build.ninja && cmake .. -G"Ninja" -DAPP=$(APP) -DBOARD=$(BOARD) -DRTOS=$(RTOS)
	ninja -C build.ninja -j8
	@make vmem

# program:
# 	ninja programtask -C build.ninja -j8

# unlock:
# 	ninja programunlock -C build.ninja -j8

vmem:
#	ninja vmemtask -C build.ninja -j8
	@xxd -l 0x10000 -g 4 -c 4 $(OUTDIR)/$(APP)/$(APP).bin  > $(OUTDIR)/$(APP)/$(APP)foo.hex
	@perl  -ne 'if(/:\s(..)(..)(..)(..)\s/){printf("%s%s%s%s\n",  $$4,$$3,$$2,$$1)}' \
	$(OUTDIR)/$(APP)/$(APP)foo.hex > $(OUTDIR)/$(APP)/$(APP).vmem

tcl:
	@perl -ne 'if(/(..)(..)(..)(..)/){printf("riscv.cpu mww 0x%08x 0x%s%s%s%s\n", (0x8000000+$$a), $$1,$$2,$$3,$$4 );$$a+=4;}' \
	$(OUTDIR)/$(APP)/$(APP).vmem > $(OUTDIR)/$(APP)/$(APP).tcl


size:
	@echo -e \\nfiles size :
	@$(CROSS)size -d $(OUTDIR)/$(APP)/$(APP).elf
	@echo -e \\n

haltaddr:
	@$(CROSS)readelf -s $(OUTDIR)/$(APP)/$(APP).elf | grep abort | sed -e "s/.*\(08\w\+\).*/\1/"


clean:
	rm -rf output
	rm -rf build.make
	rm -rf build.eclipse
	rm -rf build.ninja
#	$(MAKECLEAN) -C firmware/bootrom
