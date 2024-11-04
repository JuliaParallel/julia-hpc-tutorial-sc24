NBCONVERT := jupyter nbconvert --template my-reveal --to slides --stdout

all: \
	01_mpi+jupyter.html \
	02_comms.html \
	03_halo.html

%.html: %.ipynb
	$(NBCONVERT) $^ > $@

clean:
	rm *.html
