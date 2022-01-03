%% 
% Class Identification
%%
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{recipes}
              [2022/01/01 v1.0 Recipes]

%% 
% No options.  This class is based on the book.cls
% and the options are loaded at this point.
%%
\LoadClass[10pt,a5paper,twoside]{book}

%% 
% Packages
%%
\RequirePackage[margin=2cm]{geometry} % Easier control over the margins
\RequirePackage{fancyhdr} % Nicer headers for the revision information
\RequirePackage[british]{babel} % UK style dates
\RequirePackage[T1]{fontenc} % Required for superscripts for ordinals, don't know why
\RequirePackage{makeidx} % Needed to create an index
\RequirePackage{multicol} % For ingredients list

%% 
% Set the font and adjust a few sizes
%%
\renewcommand{\familydefault}{cmss}
\newcommand{\smaller}{\small}
\raggedright 

%% 
% Re-organise the table of contents
%%
\renewcommand{\tableofcontents}[1]%
{
  \cleardoublepage%
  \section*{#1}%
  \markboth{\contentsname}{}%
  \par\nobreak%
  \markboth{\contentsname}{\contentsname}%
  \setcounter{tocdepth}{2}%
  \@starttoc{toc}%
  \setcounter{tocdepth}{2}%
}

%% 
% TeX delays all \write commands until \shipout time.  The result is that 
% the final \addtocontents are not getting written to the *.aux file.  To 
% get around it this macro writes out immediately.
% https://tex.stackexchange.com/questions/13914/toc-numbering-problem/13926#13926
%%
\newcommand\immediateaddtocontents[2]{%
  \begingroup
  \let\origwrite\write
  \def\write{\immediate\origwrite}%
  \addtocontents{#1}{#2}%
  \endgroup
}

%% 
% Menu Environment
%%
\newenvironment{menu}[1]%
{%
  \cleardoublepage
  \addtocounter{section}{1}%
  \immediateaddtocontents{toc}{\protect\begin{samepage}}%
  \addcontentsline{toc}{section}{#1}%
  \markboth{#1}{#1}%
  \section*{#1}%
  \immediateaddtocontents{toc}{\protect\begin{TOCRecipeList}}%
}%
{%
  \immediateaddtocontents{toc}{\protect\end{TOCRecipeList}}%
  \immediateaddtocontents{toc}{\protect\end{samepage}}%
  \setcounter{recipe}{0}% After the menu is finished set the recipe counter to zero
  \setcounter{day}{0}% After the menu is finished set the day counter to zero
}%

\newenvironment{TOCRecipeList}%
{%
  \begin{list}%
  {%
    % No Default label
  }%
  {%
    \setlength{\rightmargin}{1.5cm}%
    \setlength{\leftmargin}{1.5cm}%
    \setlength{\parsep}{-0.25em}%
    \smaller%
    \item%
  }%
}%
{%
  \item%
  \end{list}%
}%

%% 
% List of recipes in the menu
%%
\newenvironment{recipelist}%
{%
  \begin{scriptsize}%
  \begin{minipage}[t]{.5\textwidth}%
}%
{%
  \end{minipage}%
  \end{scriptsize}%
}%

%% 
% Shopping list for ingredient type
%%
\newenvironment{shoppinglist}[1]%
{%
  \begin{minipage}[t]{.5\textwidth}%
  \subsubsection*{#1}%
}%
{%
  \end{minipage}%
}%

%%
% Lines for writing other items on the shopping list
%%
\newcommand{\othershoppinglist}[1]%
{%
  \begin{minipage}[t][\height][s]{.48\textwidth}%
  \subsubsection*{#1}%
  \smallskip%
  \hrulefill \par \bigskip % 1
  \hrulefill \par \bigskip % 2
  \hrulefill \par \bigskip % 3
  \hrulefill \par \bigskip % 4
  \hrulefill % 5
  \end{minipage}\hfil%
}%

%% 
% Meal/Recipe Environment
%%
\newcounter{recipe} % counting recipes to get in the page breaks
\newcounter{day} % counting the days because some recipes cover 2 days
\newcounter{firstday} % a holder for the first day of a pair
\newcounter{secondday}% a holder for the second day of a pair
\newenvironment{recipe}[2]%
{
  \addtocontents{toc}{#2,}%
  \addtocounter{recipe}{1}
  \ifnum#1=2
    \addtocounter{day}{1}
    \setcounter{firstday}{\theday}
    \addtocounter{day}{1}
    \setcounter{secondday}{\theday}
    \subsection*{\raisebox{0.5ex}{\smaller Meals \thefirstday\ and \thesecondday} #2}%
  \else
    \addtocounter{day}{1}
    \subsection*{\raisebox{0.5ex}{\smaller Meal \theday} #2}%
  \fi
}
{
  \ifodd\therecipe
    \vfil
  \else
    \vfil
    \clearpage
  \fi
}

%% 
% Ingredients Environment
%%
\newenvironment{ingredients}%
{
  \begin{multicols}{2}
}
{
  \end{multicols}
}

%% 
% Instructions Environment
%%
\newcommand{\bulletPoint}{\smaller $\bullet$}
\newlength{\sizeOfABulletPoint}
\settowidth{\sizeOfABulletPoint}{\bulletPoint}
\newenvironment{instructions}
{
  \begin{minipage}{\textwidth}
    \begin{list}{\bulletPoint}
    {% I am not entirely sure why these braces are necessary
      \setlength{\itemsep}{0pt}
      \setlength{\parsep}{0pt}
      \setlength{\leftmargin}{0pt}
      \setlength{\rightmargin}{0pt}
    }
    \raggedright 
}
{
    \end{list}
  \end{minipage}
}
