
check:
	export ELF_STD_RED_RUN=./../../STD_red/STD_red_run
	../../elf/elf_h test.pm > tst_1 2> tst_2
	diff t_baseline.result tst_1
	@echo ok

old_create_baseline:
	-mkdir qout
	./remains_of_Regexp_ModuleA.pm --test > qout/test_1 2> qout/test_2
	./remains_of_Regexp_ModuleA.pm --test > qout/test_12 2>&1
	./remains_of_Regexp_ModuleA.pm --test6 > qout/test6_1 2> qout/test6_2
	./remains_of_Regexp_ModuleA.pm --test6 > qout/test6_12 2>&1
	-prove t/re_tests.t > qout/prove_re_1 2> qout/prove_re_2
	-prove t/rx.t > qout/prove_rx_1 2> qout/prove_rx_2
