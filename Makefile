TEX = atelier_vr
TEXSRC = $(TEX).tex
OUTDIR = build
PDF = $(OUTDIR)/$(TEX).pdf

LATEXMK = latexmk
LATEXMK_OPTS = -pdf -output-directory=$(OUTDIR) -jobname=$(TEX) -interaction=nonstopmode


.PHONY: all release tidy clean distclean view

# Par défaut, construire et copier le PDF à la racine
all: release

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(PDF): | $(OUTDIR)
	@echo "Compiling $(TEXSRC) -> $(PDF)"
	$(LATEXMK) $(LATEXMK_OPTS) $(TEXSRC)

# release: build puis copier le PDF à la racine
release: $(PDF)
	@echo "Copying $(PDF) to $(TEX).pdf at project root"
	@cp -f $(PDF) $(TEX).pdf

# tidy: place auxiliary files into build/ (latexmk already writes aux files to output dir)
tidy: ; @echo "Auxiliaires stockés dans $(OUTDIR)/"

clean:
	@echo "Cleaning auxiliary files in $(OUTDIR)"
	-@find $(OUTDIR) -type f \( -name '*.aux' -o -name '*.log' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' -o -name '*.nav' -o -name '*.snm' \) -delete || true

distclean: clean
	@echo "Removing generated PDF and build directory"
	-@rm -f $(PDF) || true
	-@rm -f $(TEX).pdf || true
	-@rmdir $(OUTDIR) 2>/dev/null || true

view: $(TEX).pdf
	@echo "Open PDF with default viewer"
	-@xdg-open $(TEX).pdf 2>/dev/null || true
