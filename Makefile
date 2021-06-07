PREFIX ?= /usr/local
BIN := $(wildcard lf*)

.PHONY: all install uninstall

all :

install :
	@mkdir -pv ${DESTDIR}${PREFIX}/bin
	@cp -fv ${BIN} ${DESTDIR}${PREFIX}/bin/
	@chmod 755 $(addprefix ${DESTDIR}${PREFIX}/bin/,${BIN})

uninstall :
	@rm -fv $(addprefix ${DESTDIR}${PREFIX}/bin/,${BIN})
