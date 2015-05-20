sphinx:
  pip.installed

formic:
  pip.installed:
    - require_in:
      - pip: livereload
livereload:
  pip.installed


sphinx_pdf_deps:
  pkg.installed:
    - pkgs:
      - texlive-latex-base
      - texlive-fonts-recommended
      - texlive-latex-extra

