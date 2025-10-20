TEX = atelier_vr
TEXSRC = $(TEX).tex
OUTDIR = build
PDF = $(OUTDIR)/$(TEX).pdf
VENV = .venv
REQUIREMENTS = requirements.txt

LATEXMK = latexmk
LATEXMK_OPTS = -pdf -output-directory=$(OUTDIR) -jobname=$(TEX) -interaction=nonstopmode


.PHONY: all release clean distclean view install venv

# Par défaut, construire et copier le PDF à la racine
all: release

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(PDF): | $(OUTDIR)
	@echo "Compiling $(TEXSRC) -> $(PDF)"
	# Ensure minted can call pygmentize. Prefer .venv if present by prepending it to PATH.
	# Use latexmk with a pdflatex command that includes -shell-escape.
	PATH=$(VENV)/bin:$$PATH $(LATEXMK) $(LATEXMK_OPTS) -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" $(TEXSRC)

# Create a Python virtual environment and install pip requirements.
venv:
	@echo "Creating virtualenv in $(VENV) and installing requirements"
	@python3 -m venv $(VENV)
	@$(VENV)/bin/pip install --upgrade pip
	@if [ -f $(REQUIREMENTS) ]; then $(VENV)/bin/pip install -r $(REQUIREMENTS); else echo "No $(REQUIREMENTS) found, skipping pip install"; fi

install: venv
	@echo "Virtualenv ready ($(VENV))."

# release: build puis copier le PDF à la racine
release: $(PDF)
	@echo "Copying $(PDF) to $(TEX).pdf at project root"
	@cp -f $(PDF) $(TEX).pdf

# tidy: place auxiliary files into build/ (latexmk already writes aux files to output dir)
tidy: ; @echo "Auxiliaires stockés dans $(OUTDIR)/"

clean:
	@echo "Cleaning auxiliary files in $(OUTDIR)"
	-@find $(OUTDIR) -type f \( -name '*.aux' -o -name '*.log' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' -o -name '*.nav' -o -name '*.snm' \) -delete || true
	# Remove minted auxiliary directory and intermediate pygtex files at project root
	-@rm -rf _minted-$(TEX) || true
	-@find . -maxdepth 1 -type f -name '*.pygtex' -delete || true
	-@rm -f $(TEX).pdf || true

distclean: clean
	@echo "Removing generated PDF and build directory"
	-@rm -f $(PDF) || true
	-@rm -f $(TEX).pdf || true
	-@rmdir $(OUTDIR) 2>/dev/null || true

view: $(TEX).pdf
	@echo "Open PDF with default viewer"
	-@xdg-open $(TEX).pdf 2>/dev/null || true
