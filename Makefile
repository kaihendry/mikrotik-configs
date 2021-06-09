sunny.rsc:
	ssh 192.168.1.1 "/export hide-sensitive" > $@
.PHONY: sunny.rsc

praze.rsc:
	ssh 81.187.180.129 "/export compact hide-sensitive" > $@
.PHONY: praze.rsc

clean:
	rm -f *.rsc
