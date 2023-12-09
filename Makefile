ddb := duckdb -init '' -line -c
$(VERBOSE).SILENT:
.PHONY: solution0 solution1 solution2 solutions clean

solution0.csv: puzzle0.sql
	$(ddb) ".read puzzle0.sql" 

5784: solution0.csv
	wget https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip
	unzip -P $(shell tail -n1 $<) noahs-jsonl.zip
	gzip -9 5784/noahs-*.jsonl
	rm noahs-jsonl.zip
	mv 5784/noahs*.jsonl.gz .

solution0: solution0.csv
	@echo "\nSolution 0"
	@echo "----------"
	@echo "Hebrew Year = $(shell tail -n1 $<)"

solution1: 5784
	@echo "\nSolution 1"
	@echo "----------"
	$(ddb) ".read puzzle1.sql"

solution2: 5784
	@echo "\nSolution 2"
	@echo "----------"
	$(ddb) ".read puzzle2.sql"

solutions: solution0 solution1 solution2

clean:
	rm -rf 5784
	rm -f noahs-*.jsonl.gz
	rm -f solution0.csv

