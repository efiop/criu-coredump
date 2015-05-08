loop:
	gcc -g $@.c -o $@
	chmod +x $@

run: clean loop
	./test.sh

clean:
	rm -f loop core.* *.img
