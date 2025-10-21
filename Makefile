TEX = atelier_vr
TEXSRC = $(TEX).tex
OUTDIR = build
PDF = $(OUTDIR)/$(TEX).pdf
VENV = .venv
REQUIREMENTS = requirements.txt


DOCSIMPL = doc/atelier_vr_simplifie.tex
DOCAVANCE = doc/atelier_vr_avance.tex
VENV = doc/.venv
MINTED = doc/_minted-atelier_vr
BUILDDIR = doc/build
RELEASEDIR = doc/release
PDFSIMPL = $(RELEASEDIR)/atelier_vr_simplifie.pdf
PDFAVANCE = $(RELEASEDIR)/atelier_vr_avance.pdf

LATEXMK = latexmk
LATEXMK_OPTS = -pdf -interaction=nonstopmode



.PHONY: all pdf-simplifie pdf-avance clean distclean install venv


all: pdf-simplifie pdf-avance


pdf-simplifie: $(PDFSIMPL)
pdf-avance: $(PDFAVANCE)


$(PDFSIMPL): $(DOCSIMPL) | $(RELEASEDIR) $(BUILDDIR)
	@echo "Compiling $< -> $@"
	cd doc && PATH=.venv/bin:$$PATH latexmk -pdf -interaction=nonstopmode -shell-escape -output-directory=build $(notdir $(DOCSIMPL))
	@mv doc/build/atelier_vr_simplifie.pdf doc/release/atelier_vr_simplifie.pdf


$(PDFAVANCE): $(DOCAVANCE) | $(RELEASEDIR) $(BUILDDIR)
	@echo "Compiling $< -> $@"
	cd doc && PATH=.venv/bin:$$PATH latexmk -pdf -interaction=nonstopmode -shell-escape -output-directory=build $(notdir $(DOCAVANCE))
	@mv doc/build/atelier_vr_avance.pdf doc/release/atelier_vr_avance.pdf
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(RELEASEDIR):
	mkdir -p $(RELEASEDIR)






clean:
	@echo "Cleaning auxiliary files in ./doc/build"
	-@find $(BUILDDIR) -type f \( -name '*.aux' -o -name '*.log' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' -o -name '*.nav' -o -name '*.snm' \) -delete || true
	-@rm -rf $(BUILDDIR)/_minted-* || true
	-@find $(BUILDDIR) -maxdepth 1 -type f -name '*.pygtex' -delete || true



distclean: clean
	@echo "Removing generated PDFs and build/release/minted directories"
	-@rm -rf $(BUILDDIR) $(RELEASEDIR) $(MINTED) || true

	-@rmdir $(OUTDIR) 2>/dev/null || true

view: $(TEX).pdf
	@echo "Open PDF with default viewer"
	-@xdg-open $(TEX).pdf 2>/dev/null || true
