.PHONY : clean

source.md: text.md
	pandoc text.md -o source.md

assets: example-md
	cp -R example-md assets

clean :
	rm -rf assets source.md
