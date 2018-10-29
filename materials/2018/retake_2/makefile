# makefile: Rnw -> tex -> pdf
# .Rnw extension is automatically added
file_name = retake_2018_2
file_name2 = retake_2018_kr_base

all: $(file_name).pdf $(file_name2).pdf

$(file_name).pdf: $(file_name).tex 2017_kr_04_final.tex title_bor_utf8.tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -xelatex -shell-escape $(file_name).tex

	# clean auxillary files
	latexmk -c $(file_name).tex

# $(file_name).tex : $(file_name).Rnw
#	Rscript -e "library(knitr); knit('$(file_name).Rnw')"

$(file_name2).pdf: $(file_name2).tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -xelatex -shell-escape $(file_name2).tex

	# clean auxillary files
	latexmk -c $(file_name2).tex




clean:
	-rm $(file_name).pdf $(file_name).log $(file_name).fls $(file_name).aux $(file_name).bbl $(file_name).bcf $(file_name).fdb_latexmk $(file_name).out $(file_name).run.xml $(file_name).toc $(file_name).amc $(file_name)-concordance.tex
	-rm junk.txt
