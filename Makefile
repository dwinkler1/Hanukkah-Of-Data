ddb := duckdb -init '' -line -c
$(VERBOSE).SILENT:
.PHONY: solution0 solution1 solution2 solution3 solution4 solution5 solution6 solution7 solution8
.PHONY: solutions clean

solution0.csv: puzzle0.sql
	$(ddb) ".read $<" 

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

solution1: puzzle1.sql 5784
	@echo "\nSolution 1"
	@echo "----------"
	$(ddb) ".read $<"

solution2: puzzle2.sql 5784
	@echo "\nSolution 2"
	@echo "----------"
	$(ddb) ".read $<"

solution3: #puzzle3.sql 5784
	@echo "\nSolution 3"
	@echo "----------"
#	$(ddb) ".read $<"

solution4: #puzzle4.sql 5784
	@echo "\nSolution 4"
	@echo "----------"
#	$(ddb) ".read $<"

solution5: #puzzle5.sql 5784
	@echo "\nSolution 5"
	@echo "----------"
#	$(ddb) ".read $<"

solution6: #puzzle6.sql 5784
	@echo "\nSolution 6"
	@echo "----------"
#	$(ddb) ".read $<"

solution7: #puzzle7.sql 5784	
	@echo "\nSolution 7"
	@echo "----------"
#	$(ddb) ".read $<"

solution8: #puzzle8.sql 5784
	@echo "\nSolution 8"
	@echo "----------"
#	$(ddb) ".read $<"

solutions: solution0 solution1 solution2 solution3 solution4 solution5 solution6 solution7 solution8

clean:
	rm -rf 5784
	rm -f noahs-*.jsonl.gz
	rm -f solution0.csv

