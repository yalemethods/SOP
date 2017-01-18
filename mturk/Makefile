.PHONY : clean

source.md : qualtrics_mturk_checklist.md
	pandoc qualtrics_mturk_checklist.md -o source.md

assets : mturk
	cp -R mturk assets

clean :
	rm -rf assets source.md
