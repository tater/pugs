.PHONY : prove

PROVE := $(shell if prove --version | grep v2 > /dev/null 2>&1;then echo 'prove -r --perl'; else echo 'prove -r -e'; fi)

test: clean prove

prove:
	$(PROVE) 'perl mildew --exec --file' t/

clean:
	rm -rf lex
