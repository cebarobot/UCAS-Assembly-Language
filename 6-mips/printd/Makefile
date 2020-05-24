FINAL_OBJECT := main
OBJECTS := main.o printd.o

CROSS_PREFIX := mipsel-linux-gnu-
CC := $(CROSS_PREFIX)gcc
AS := $(CROSS_PREFIX)as
LD := $(CROSS_PREFIX)ld
OBJDUMP := $(CROSS_PREFIX)objdump
OBJCOPY := $(CROSS_PREFIX)objcopy

EMULATE_RUN := qemu-mipsel-static

$(FINAL_OBJECT): $(OBJECTS)
	@echo "\33[33mlinking...\33[0m"
	$(LD) $(OBJECTS) $(LD_FLAGS) -o $(FINAL_OBJECT)

$(OBJECTS): %.o: %.S
	@echo "\33[33massembling $< ...\33[0m"
	$(AS) $(AS_FLAGS) $< -o $@

.PHONY: run
run: $(FINAL_OBJECT)
	@echo "\33[33mruning...\33[0m"
	$(EMULATE_RUN) $(FINAL_OBJECT)
	@echo "\33[33mdone.\33[0m"

.PHONY: clean
clean:
	-rm $(FINAL_OBJECT) $(OBJECTS)
