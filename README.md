## amznotes + LLM System Design Notes
This repository contains the `amznotes` LaTeX document class and a concrete example project: **Top 25 LLMs System Design Interview Questions** (`interview_questions.tex` → `interview_questions.pdf`).

The class is great for pretty, box-based technical notes; the example book shows how to use it for a polished interview prep booklet.

### Quick Start: Build the LLM System Design Book

1. **Install prerequisites**  
   - A modern TeX distribution with **LuaLaTeX** support (TeX Live, MacTeX, etc.)  
   - Fonts: STIX Two Text, STIX Two Math, Inconsolata (see details below)  
   - `emoji` and `minted` LaTeX packages plus Python `Pygments` for code highlighting.

2. **Clone and build**
   ```bash
   git clone <this-repo-url>
   cd amznotes

   # Recommended: uses .latexmkrc (LuaLaTeX + continuous preview)
   latexmk interview_questions.tex

   # Or, using the provided Makefile
   make interview_questions.pdf
   ```

3. **Open the PDF**
   - `interview_questions.pdf` will be written next to `interview_questions.tex`.
   - `sample.pdf` shows the original minimal demo of the `amznotes` class.

---

## amznotes class overview
This is the LaTeX document class I use to write notes. Check out a [sample](https://github.com/alexmingzhang/latex-notes-template/blob/main/sample.pdf)

[![sample image](https://github.com/alexmingzhang/amznotes/blob/main/images/sample-1.jpg)](https://github.com/alexmingzhang/latex-notes-template/blob/main/sample.pdf)

## Guide for Running and Rendering LaTeX Code

### Prerequisites

Before using the `amznotes` class, ensure you have the following installed:

#### 1. LaTeX Distribution
The `amznotes` class requires a **modern engine** such as **XeLaTeX or LuaLaTeX** (not pdfLaTeX) because it uses `fontspec` and `unicode-math`.  
In **this repository**, the default tooling (`.latexmkrc`, `Makefile`) is configured for **LuaLaTeX** to support emoji.

- **macOS**: MacTeX (full) or BasicTeX (minimal)
  ```bash
  brew install --cask mactex  # Full version
  # or
  brew install --cask basictex  # Minimal version
  ```

- **Ubuntu/Debian**:
  ```bash
  sudo apt-get install texlive-xetex texlive-latex-extra texlive-fonts-recommended
  ```

- **Windows**: TeX Live or MiKTeX
- **Other systems**: Check [TeX Live](https://www.tug.org/texlive/) for your platform

#### 2. Required Fonts
The class uses specific fonts that need to be installed on your system:

- **STIX Two Text** and **STIX Two Math** (for main text and mathematics)
- **Inconsolata** (for monospace/code text)

Download and install from:
- [STIX Fonts](https://www.stixfonts.org/)
- [Inconsolata Font](https://fonts.google.com/specimen/Inconsolata)

On macOS with Homebrew:
```bash
brew install font-stix font-inconsolata
```

#### 3. Additional Dependencies
The class requires several LaTeX packages. Most modern TeX distributions include these, but you may need to install additional packages:

```bash
# For Ubuntu/Debian
sudo apt-get install texlive-science texlive-humanities

# For macOS with BasicTeX, install additional packages
sudo tlmgr install tcolorbox minted fvextra upquote lineno
```

### Installation

#### Option 1: Local Installation (Recommended)
1. Download `amznotes.cls` to your project directory
2. Place your `.tex` files in the same directory as `amznotes.cls`

#### Option 2: Global Installation
1. Download `amznotes.cls`
2. Place it in your local TeX directory:
   - **macOS/Unix**: `~/Library/texmf/tex/latex/` or `/usr/local/texlive/texmf-local/tex/latex/`
   - **Windows**: `%APPDATA%\MiKTeX\2.9\tex\latex\` or similar
3. Run `mktexlsr` to refresh the TeX file database

### Basic Usage

#### Document Structure
Create a `.tex` file with the following structure:

```latex
\documentclass[math,code]{amznotes}  % Options: math, code, fastcompile

\usepackage{lipsum}  % Any additional packages you need

\begin{document}
    \tableofcontents

    \chapter{Your Chapter Title}

    \section{Your Section}

    Your content here...

    \amzindex  % Optional: generates index of all boxes used

\end{document}
```

#### Document Class Options
- `math`: Enables theorem boxes, math macros, and mathematical environments
- `code`: Enables code boxes and syntax highlighting
- `fastcompile`: Disables fancy styling for faster compilation during editing

### Compilation

#### Method 1: Command Line (Recommended)
Use XeLaTeX or LuaLaTeX to compile your document:

```bash
# Single compilation (usually sufficient for simple documents)
lualatex yourfile.tex      # or: xelatex yourfile.tex

# Multiple compilations (needed for table of contents, references, index)
lualatex yourfile.tex
lualatex yourfile.tex      # Run twice for TOC/references
```

#### Method 2: Using Make
Create a `Makefile` in your project directory:

```makefile
.PHONY: all clean

all: sample.pdf

%.pdf: %.tex amznotes.cls
	xelatex $<
	xelatex $<  # Second run for TOC/references

clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
```

Then run:
```bash
make all
```

#### Method 3: Using latexmk (Recommended for Complex Documents)
Install latexmk and create a `.latexmkrc` file:

```perl
$pdf_mode = 5;  # Use xelatex
$bibtex_use = 2;
$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode';
```

Then compile with:
```bash
latexmk yourfile.tex
```

#### Method 4: Using VS Code with LaTeX Workshop
Add to your VS Code `settings.json`:

```json
{
    "latex-workshop.latex.recipes": [
        {
            "name": "xelatex",
            "tools": ["xelatex"]
        },
        {
            "name": "xelatex -> bibtex -> xelatex*2",
            "tools": ["xelatex", "bibtex", "xelatex", "xelatex"]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": ["%DOCFILE%"]
        }
    ]
}
```

### Features and Usage

#### Math Support (with `math` option)
When using the `math` option, you get access to theorem boxes and math macros:

```latex
\begin{thmbox}{Pythagorean Theorem}{pythagoras}
    For a right triangle with legs $a$ and $b$, and hypotenuse $c$:
    \[ a^2 + b^2 = c^2 \]
    \tcblower
    \begin{proof}
        This is a well-known theorem in geometry.
    \end{proof}
\end{thmbox}
```

Available math macros:
- Number sets: `\N`, `\Z`, `\Q`, `\R`, `\C`, `\F`
- Operators: `\laplace`, `\bigO`
- Delimiters: `\abs{}`, `\norm{}`, `\floor{}`, `\ceil{}`

#### Code Support (with `code` option)
For syntax-highlighted code blocks:

```latex
\begin{codebox}{Hello World in Python}{python-hello}
    \begin{amzcode}{python}
def hello_world():
    print("Hello, World!")

hello_world()
    \end{amzcode}
\end{codebox}
```

Or include code from external files:
```latex
\amzinputcode{python}{hello.py}
```

#### Box Types
The class provides several predefined colored boxes:

**Numbered/Indexable Boxes:**
- `\dfnbox` - Definitions (blue)
- `\exbox` - Examples (yellow)
- `\tecbox` - Techniques (red)
- `\thmbox` - Theorems (purple, requires `math` option)
- `\codebox` - Code snippets (gray, requires `code` option)

**Unnumbered Boxes:**
- `\genbox` - General information (green)
- `\notebox` - Notes (red border)

#### Custom Boxes
Create your own boxes using `\newamzbox`:

```latex
\newamzbox{warningbox}{Warning}{warn}{orange}
```

Then use it:
```latex
\begin{warningbox}{Important Warning}{important}
    This is a custom warning box.
\end{warningbox}
```

### Troubleshooting

#### Common Issues

1. **Font Not Found Error**
   ```
   Font STIXTwoText-Regular.otf not found
   ```
   **Solution**: Install the STIX Two fonts as described in Prerequisites.

2. **Package Not Found**
   ```
   ! LaTeX Error: File `tcolorbox.sty' not found
   ```
   **Solution**: Install missing packages with your TeX package manager:
   ```bash
   # TeX Live
   tlmgr install tcolorbox minted

   # Ubuntu/Debian
   sudo apt-get install texlive-latex-extra
   ```

3. **Minted Package Issues**
   ```
   Package minted Error: You must have `pygmentize' installed
   ```
   **Solution**: Install Python and Pygments:
   ```bash
   pip install Pygments
   # or
   conda install pygments
   ```

4. **Compilation Hangs or Slow**
   - Use the `fastcompile` option during editing
   - Close PDF viewer while compiling
   - Use `latexmk` for automatic recompilation on changes

5. **Index Not Generated**
   - Ensure `\amzindex` is placed before `\end{document}`
   - Compile multiple times for proper indexing

#### Performance Tips
- Use `fastcompile` option for faster editing cycles
- Close PDF viewers during compilation
- Use `latexmk` for automatic dependency handling
- For large documents, consider splitting into multiple files

### Example Project Structure

```
your-project/
├── amznotes.cls          # The document class
├── main.tex             # Your main document
├── chapters/            # Optional: separate chapter files
│   ├── intro.tex
│   └── content.tex
├── images/              # Images and figures
├── code/                # External code files
└── Makefile             # Optional: for automation
```

### Quick Start Template

```latex
\documentclass[math,code]{amznotes}

\begin{document}

\tableofcontents

\chapter{Getting Started}

\section{Your First Section}

\begin{notebox}
    Welcome to amznotes! This is a note box.
\end{notebox}

\begin{exbox}{Simple Example}{first-example}
    This is your first example box.
\end{exbox}

\amzindex

\end{document}
```

Compile with: `xelatex yourfile.tex`
