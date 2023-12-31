data_link := https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip
ddb := duckdb -init '' -line -c
$(VERBOSE).SILENT:
sols := $(patsubst %, solution%, 1 2 3 4 5 6 7 8)
.PHONY: $(sols)
.PHONY: solutions clean

solution0.csv: puzzle0.sql
	$(ddb) ".read $<" 

5784: solution0.csv
	wget $(data_link)
	unzip -P $(shell tail -n1 $<) noahs-jsonl.zip
	gzip -9 5784/noahs-*.jsonl
	rm noahs-jsonl.zip
	mv 5784/noahs*.jsonl.gz .

solution0: solution0.csv
	@echo "\nSolution 0"
	@echo "----------"
	@echo "Hebrew Year = $(shell tail -n1 $<)"

solution1: puzzle1.sql 5784
	@echo "\nSolution 1"
	@echo "----------"
	$(ddb) ".read $<"

solution2.csv: puzzle2.sql 5784
	$(ddb) ".read $<"

solution2: solution2.csv
	@echo "\nSolution 2"
	@echo "----------"
	@echo " name = $(shell tail -n1 $< | cut -d, -f1)"
	@echo "phone = $(shell tail -n1 $< | cut -d, -f2)"

aux_chinese_zodiac.jsonl: chinese_zodiac.sql
	$(ddb) ".read $<"

aux_astrological_signs.jsonl: astrological_signs.sql
	$(ddb) ".read $<"

solution3: puzzle3.sql solution2.csv aux_chinese_zodiac.jsonl aux_astrological_signs.jsonl 5784
	@echo "\nSolution 3"
	@echo "----------"
	$(ddb) ".read $<"

solution4: puzzle4.sql 5784
	@echo "\nSolution 4"
	@echo "----------"
	$(ddb) ".read $<"

solution5: puzzle5.sql 5784
	@echo "\nSolution 5"
	@echo "----------"
	$(ddb) ".read $<"

solution6.csv: puzzle6.sql 5784
	$(ddb) ".read $<"

solution6: solution6.csv
	@echo "\nSolution 6"
	@echo "----------"
	@echo " name = $(shell tail -n1 $< | cut -d, -f1)"
	@echo "phone = $(shell tail -n1 $< | cut -d, -f2)"

solution7: puzzle7.sql 5784	
	@echo "\nSolution 7"
	@echo "----------"
	$(ddb) ".read $<"

solution8: puzzle8.sql 5784
	@echo "\nSolution 8"
	@echo "----------"
	$(ddb) ".read $<"

solutions: $(sols)

clean:
	rm -rf 5784
	rm -f noahs-*.jsonl.gz
	rm -f solution*.csv
	rm -f aux*.jsonl

