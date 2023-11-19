praze.rsc:
	ssh 81.187.180.129 "/export compact"  > $@

workshop.rsc:
	ssh 81.187.180.159 "/export compact"  > $@

clean:
	rm -f *.rsc
