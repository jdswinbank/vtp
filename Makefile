# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = vtp

# count up; you probably do not want to bother with versions <1.0
DOCVERSION := $(shell git describe)

# Publication date, ISO format; update manually for "releases"
DOCDATE := $(shell git log -1 --date=short --pretty=%ad)-git

# What is it you're writing: NOTE, WD, PR, or REC
DOCTYPE = WD

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex

# List of pixel image files to be included in submitted package
FIGURES =

# List of PDF figures (for vector graphics)
VECTORFIGURES = figures/authortobroker.pdf figures/brokertosub.pdf figures/network.pdf figures/brokerfromauthor.pdf figures/subfrombroker.pdf

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES =

include ivoatex/Makefile

# We'll use GraphicsMagick to do PDF to PNG conversion...
CONVERT = gm convert

# ...and avoid unnecessary use of temporary files.
%.pdf.png: %.pdf
	$(CONVERT) -density 300 -scale 25% $< $@
