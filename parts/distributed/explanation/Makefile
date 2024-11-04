NBCONVERT := jupyter nbconvert --template my-reveal --to slides --stdout

all: \
	01_distributed.html \
	02_dagger.html

%.html: %.ipynb
	$(NBCONVERT) $^ > $@

clean:
	rm *.html
