%% 
% Class Identification
%%
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{cookbook}
              [1996/08/01 v1.0 F'F'Cookbook]

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
\RequirePackage{minitoc} % For mini table of contents

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
  \setcounter{tocdepth}{1}%
  \@starttoc{toc}%
  \setcounter{tocdepth}{2}%
}

%% 
% Menu Environment - menus are ordered Alphabetically
%%
\renewcommand{\thesection}{\Alph{section}}%
\newenvironment{menu}[1]%
{
  \cleardoublepage
  \addtocounter{section}{1}%
  \section*{Menu \thesection\hfill #1}%
}
{
  \setcounter{recipe}{0} % After the menu is finished set the recipe counter to zero
  \setcounter{day}{0} % After the menu is finished set the day counter to zero
}

%% 
% Shopping List Command
%%
\newenvironment{shoppinglist}[1]%
{%
  \begin{minipage}[t]{.49\textwidth}%
    \subsubsection*{#1}
   % \raggedright%
}%
{%
  \end{minipage}%
}%

%%
% Lines for writing other items on the shopping list
%%
\newcommand{\othershoppinglist}[1]%
{%
        \begin{minipage}[t][\height][s]{.49\textwidth}%
        \subsubsection*{#1}%
        \smallskip%
        \hrulefill \par \bigskip % 1
        \hrulefill \par \bigskip % 2
        \hrulefill \par \bigskip % 3
        \hrulefill \par \bigskip % 4
        \hrulefill \par \bigskip % 5 
        \hrulefill \par \bigskip % 6 
        \hrulefill \par \bigskip % 7 
        \hrulefill \par \bigskip % 8
        \hrulefill \par \bigskip % 9
        \hrulefill %               10
        \end{minipage}%
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
  \addtocounter{recipe}{1}
  \ifnum#1=2
    \addtocounter{day}{1}
    \setcounter{firstday}{\theday}
    \addtocounter{day}{1}
    \setcounter{secondday}{\theday}
    \subsection*{\raisebox{0.5ex}{\smaller Meals \thefirstday\ and \thesecondday} #2}%
  \else
    \addtocounter{day}{1}
    \section*{\raisebox{0.5ex}{\smaller Meal \theday} #2}%
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
