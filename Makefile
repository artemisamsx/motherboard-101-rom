REGIONS=int us jp uk fr de it es ar ko ru
TARGET=artemisa.rom
DEVICE=SST39SF040

roms=$(patsubst %,msx-system/base/1.0/target/msx-%.rom,$(REGIONS)) adt/adt.rom

.PHONY: all
all: ${TARGET}

adt/adt.rom:
	$(MAKE) -C adt/

msx-system/base/1.0/%.rom:
	$(MAKE) -C msx-system/base/1.0 $*.rom

artemisa.rom: ${roms}
	cat ${roms} > artemisa.rom

.PHONY: burn
burn: ${ROM_IMAGE}
	minipro -p ${DEVICE} -w ${ROM_IMAGE} -S

.PHONY: clean
clean:
	rm -f ${TARGET} ${roms}
