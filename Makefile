# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = vtp

# The version is the most recent annotated tag
DOCVERSION := $(shell git describe --abbrev=0)

# The date corresponds to the version above; ISO format
DOCDATE := $(shell git tag -l $(DOCVERSION) --format="%(taggerdate:short)")

# Version information extracted from git.
GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ai)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

# What is it you're writing: NOTE, WD, PR, or REC
DOCTYPE = PR

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex

# List of pixel image files to be included in submitted package
FIGURES =

# List of PDF figures (for vector graphics)
VECTORFIGURES = figures/ivoa_arch-vtp.pdf figures/authortobroker.pdf figures/brokertosub.pdf figures/network.pdf figures/brokerfromauthor.pdf figures/subfrombroker.pdf

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES =

include ivoatex/Makefile

# We'll use GraphicsMagick to do PDF to PNG conversion...
CONVERT = gm convert

.FORCE:

ivoatexmeta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\ivoaDocversion}{$(DOCVERSION)}' >>$@
	/bin/echo '\newcommand{\ivoaDocdate}{$(DOCDATE)}' >>$@
	/bin/echo '\newcommand{\ivoaDocdatecode}{$(DOCDATE)}' | sed -e 's/-//g' >>$@
	/bin/echo '\newcommand{\ivoaDoctype}{$(DOCTYPE)}' >>$@
	/bin/echo '\newcommand{\ivoaDocname}{$(DOCNAME)}' >>$@
	/bin/echo '\vcsrevision{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\vcsdate{$(GITDATE)}' >>$@
