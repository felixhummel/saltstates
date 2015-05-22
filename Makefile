# shorthand. "make" here. done.
.PHONY: highstate
highstate:
	sudo -i salt-call state.highstate

