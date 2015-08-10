.PHONY: all clean

all: example.go sched.y.go ming.go
	go fmt
	go build ming.go
	go build example.go
	./example

clean:
	@go clean
	rm -f y.output
	rm -f example.go
	rm -f ming.go
	rm -f sched.y.go
	rm -f sched.y
	rm -f ming.y

example.go: example.l
	golex -t $< | gofmt > $@

sched.y.go: sched.y
	go tool yacc -o $@ $<

ming.go: ming.y
	go tool yacc -o $@ $<

ming.y: ming.ebnf
	ebnf2y -pkg gen -start Operand -o $@ $< 

sched.y: sched.ebnf
	ebnf2y -pkg gen -start Sched -o $@ $< 
