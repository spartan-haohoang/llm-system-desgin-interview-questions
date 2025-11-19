.PHONY: all clean help sample

# Default target
all: sample.pdf

# Compile any .tex file to .pdf using lualatex (for better emoji support)
%.pdf: %.tex amznotes.cls
	lualatex $<
	lualatex $<  # Second run for TOC/references/index

# Specific target for the sample document
sample: sample.pdf

# Clean auxiliary files
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
	rm -f sample.pdf

# Show available targets
help:
	@echo "Available targets:"
	@echo "  all      - Compile sample.pdf (default)"
	@echo "  sample   - Compile sample.pdf"
	@echo "  %.pdf    - Compile any .tex file to PDF"
	@echo "  clean    - Remove auxiliary and output files"
	@echo "  help     - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make                    # Compile sample.pdf"
	@echo "  make myfile.pdf         # Compile myfile.tex to myfile.pdf"
	@echo "  make clean              # Clean up auxiliary files"
