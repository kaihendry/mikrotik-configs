sunny.rsc:
	ssh 192.168.1.1 "/export hide-sensitive" > $@

praze.rsc:
	ssh house "/export hide-sensitive" > $@

clean:
	rm -f *.rsc
