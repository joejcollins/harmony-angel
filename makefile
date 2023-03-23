# Consistent set of make tasks.
.DEFAULT_GOAL:= help  # because it's is a safe task.

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

build: # Build the .net project and create the latex files from the xml.
	cd src; dotnet build .; dotnet run .

pdf: # Generate the pdfs from the latex.
	cd reports/FoodFile; pdflatex FoodFile.tex; makeindex FoodFile.tex; pdflatex FoodFile.tex; pdflatex FoodFile2up.tex
