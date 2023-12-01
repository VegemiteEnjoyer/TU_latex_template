% This document class provides a simple memo for LaTeX users styled for Tohoku University.
% It is based on article.cls and inherits most of the functionality
% that class.
% 
% Author: Ruben Vescovo, based in part on the work the project by Rob Oakes, see:
% https://www.overleaf.com/latex/templates/memo-template/xfgfwnxzcgkf
%
% The code is covered under the MIT No Attribution License (MIT-0), a copy of the license  
% can be found in the LICENSE.md file in this package and at the following address: 
% https://opensource.org/license/mit/
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TUmemorandum}[2010/07/31 - Tohoku University Memo Class, Including Logo]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}
\RequirePackage[l2tabu,orthodox]{nag}
%
% l2tabu checks for obsolete code, orthodox checks for bad code
% meta info http://rudvfaden.github.io/Latex-packages/ more info 
% available at the documentation page on CTAN but l2tabu is 
% originally a German package with English translation downstream
%
\RequirePackage{fontspec}
\RequirePackage[right=2cm,left=1.5cm,top=0cm, bottom=1cm,includehead,includefoot]{geometry}
\RequirePackage{lipsum}
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\setmainfont{NotoSans-Regular}

\RequirePackage[CJKspace]{xeCJK}
\setCJKmainfont{Noto Sans JP}
\setCJKsansfont{Noto Sans JP}
\setCJKmonofont{Noto Sans JP}
%
% typography options
% \RequirePackage{everypage}
\RequirePackage{parskip} % Adds spacing between paragraphs
\setlength{\parindent}{10pt} % Indent paragraphs
%
\RequirePackage{hyperref}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz} 
\usetikzlibrary{calc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
%
\hypersetup{
    colorlinks=true,
    citecolor=Emerald, % Requires dvipsnames in xcolor package.
    linkcolor=OrangeRed, % Requires dvipsnames in xcolor package.
    filecolor=Plum, % Requires dvipsnames in xcolor package.   
    urlcolor=WildStrawberry, % Requires dvipsnames in xcolor package.
    pdftitle={Overleaf Example},
    pdfpagemode=FullScreen,
    }
% color definition based on the 2022 IRIDeS press kit 
\definecolor{tu}{RGB}{62,21,134} % Tohoku University purple
\definecolor{hl}{RGB}{126, 102, 178}% {136,100,216} {180, 145, 255} some other shades
\definecolor{lg}{RGB}{172, 193, 55} % light green
\definecolor{dg}{RGB}{0, 102, 58} % dark green
\definecolor{or}{RGB}{246, 137, 31} % orange
\definecolor{dr}{RGB}{131, 56, 60} % dark red
\definecolor{mg}{RGB}{146, 39, 142} % magenta
\definecolor{pbg}{RGB}{142, 177, 196} % paster blue gray
\definecolor{pv}{RGB}{95, 78, 125} % pastel violet
%
\setlength{\headheight}{14pt}
%
% % ----------- REFERENCES -----------
% https://tex.stackexchange.com/questions/126155/how-to-set-colored-ruled-margins-for-some-pages
% https://tex.stackexchange.com/questions/509563/absolute-positioning-of-tikz-drawings
\fancypagestyle{plain}{%
    \fancyhf{}
    \fancyhead[LO]{%
        \begin{tikzpicture}[overlay,remember picture]
            \fill [color=tu](current page.north east) rectangle
                ($ (current page.south east) + (-0.5cm,0cm) $);
        \end{tikzpicture}
        }
    \fancyfoot[R]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}
% Specialized memo Commands (Attention, From, Subject, Logo, Letterhead Address)
\def\@memoto{\relax}
\newcommand{\memoattention}[1]{\gdef\@memoattention{#1}}
%
\def\@memofrom{\relax}
\newcommand{\memofrom}[1]{\gdef\@memofrom{#1}}
%
\def\@memosubject{\relax}
\newcommand{\memosubject}[1]{\gdef\@memosubject{#1}}
%
\def\@memodate{\relax}
\newcommand{\memodate}[1]{\gdef\@memodate{#1}}
%
\def\@memologo{\relax}
\newcommand{\logo}[1]{\gdef\@memologo{\protect #1}}
%
\def\@letterheadaddress{\relax}
\newcommand{\lhaddress}[1]{\gdef\@letterheadaddress{#1}}
%
% Create the Letterhead and To/From Block with logo when logo is provided
%
\font\memofont=NotoSans-Bold at 15pt
\font\memofontb=NotoSans-Bold at 13pt
\font\titlefontbf=NotoSans-Bold at 12pt
\font\titlefont=NotoSans-Regular at 12pt
%
\renewcommand{\maketitle}{\makememotitle}
\newcommand\makememotitle{
	\ifthenelse{\equal{\@memologo}{\relax}}{}
	{ % Create With Logo
         \begin{tikzpicture}[overlay, remember picture]
            % \fill [color=hl]([xshift=-2cm, yshift=-5.25cm]current page.north east) rectangle % UNCOMMENT 2 LINES TO ADD HORIZONTAL LINE
            % ([xshift=1.5cm, yshift=-5.4cm]current page.north west);  
            % \fill [color=tu](current page.north east) rectangle
            %     ($ (current page.south east) + (-0.5cm,0cm) $);
            \node[inner sep=0pt] (logo) at (15cm,-2.2cm)
            {\@memologo};
        \end{tikzpicture}
        }
        \vspace{-20pt}
        \par %removes indent from memo table title
	\noindent \begin{minipage}[t]{\linewidth}%
        %
            \begin{center}
                \Large \memofont M\memofontb EMORANDUM
            \end{center}
        %   
        \vspace{1.6cm}
            \noindent\begin{tabular}[c]{@{}l@{} @{\quad}l@{}}
            % \noindent\begin{tabular}[c]{p{\dimexpr 95mm-2\tabcolsep} @{\quad}p{\dimexpr 95mm-2\tabcolsep}}
            
                \ifthenelse{\equal{\@memodate       }{\relax}}{}{\titlefontbf Date :        & \titlefont \@memodate \\      }
                \ifthenelse{\equal{\@memoattention  }{\relax}}{}{\titlefontbf Attention :   & \titlefont \@memoattention \\ }
                \ifthenelse{\equal{\@memofrom       }{\relax}}{}{\titlefontbf From :        & \titlefont \@memofrom \\      }
                \ifthenelse{\equal{\@memosubject    }{\relax}}{}{\titlefontbf Subject :     & \titlefont \@memosubject \\   }
            \end{tabular}
	\end{minipage}
        \vspace{0.4cm}     
}
