[![Build
Status](https://travis-ci.org/trinker/cal.svg?branch=master)](https://travis-ci.org/trinker/cal)
[![Coverage
Status](https://coveralls.io/repos/trinker/cal/badge.svg?branch=master)](https://coveralls.io/r/trinker/cal?branch=master)

**cal** is an R package designed to partially mimic the [Unix
`cal`](https://www.tutorialspoint.com/unix_commands/cal.htm) command
line tool for generating ASCII calendars in the console.

Installation
============

To download the development version of **cal**:

Download the [zip ball](https://github.com/trinker/cal/zipball/master)
or [tar ball](https://github.com/trinker/cal/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_current_gh("trinker/cal")

Examples:
=========

    cal()

    ##                                 2018                               
    ## 
    ##         March                  April                   May                               
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa                       
    ##              1  2  3    1  2  3  4  5  6  7          1  2  3  4  5                       
    ##  4  5  6  7  8  9 10    8  9 10 11 12 13 14    6  7  8  9 10 11 12                       
    ## 11 12 13 14 15 16 17   15 16 17 18 19 20 21   13 14 15 16 17 18 19                       
    ## 18 19 20 21 22 23 24   22 23 24 25 26 27 28   20 21 22 23 24 25 26                       
    ## 25 26 27 28 29 30 31   29 30                  27 28 29 30 31                             
    ## 

    cal("2017")

    ##                                            2017                                           
    ## 
    ##        January               February                 March                  April       
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##  1  2  3  4  5  6  7             1  2  3  4             1  2  3  4                      1
    ##  8  9 10 11 12 13 14    5  6  7  8  9 10 11    5  6  7  8  9 10 11    2  3  4  5  6  7  8
    ## 15 16 17 18 19 20 21   12 13 14 15 16 17 18   12 13 14 15 16 17 18    9 10 11 12 13 14 15
    ## 22 23 24 25 26 27 28   19 20 21 22 23 24 25   19 20 21 22 23 24 25   16 17 18 19 20 21 22
    ## 29 30 31               26 27 28               26 27 28 29 30 31      23 24 25 26 27 28 29
    ##                                                                      30                  
    ##          May                   June                   July                  August       
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##     1  2  3  4  5  6                1  2  3                      1          1  2  3  4  5
    ##  7  8  9 10 11 12 13    4  5  6  7  8  9 10    2  3  4  5  6  7  8    6  7  8  9 10 11 12
    ## 14 15 16 17 18 19 20   11 12 13 14 15 16 17    9 10 11 12 13 14 15   13 14 15 16 17 18 19
    ## 21 22 23 24 25 26 27   18 19 20 21 22 23 24   16 17 18 19 20 21 22   20 21 22 23 24 25 26
    ## 28 29 30 31            25 26 27 28 29 30      23 24 25 26 27 28 29   27 28 29 30 31      
    ##                                               30 31                                      
    ##       September               October               November               December      
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##                 1  2    1  2  3  4  5  6  7             1  2  3  4                   1  2
    ##  3  4  5  6  7  8  9    8  9 10 11 12 13 14    5  6  7  8  9 10 11    3  4  5  6  7  8  9
    ## 10 11 12 13 14 15 16   15 16 17 18 19 20 21   12 13 14 15 16 17 18   10 11 12 13 14 15 16
    ## 17 18 19 20 21 22 23   22 23 24 25 26 27 28   19 20 21 22 23 24 25   17 18 19 20 21 22 23
    ## 24 25 26 27 28 29 30   29 30 31               26 27 28 29 30         24 25 26 27 28 29 30
    ##                                                                      31

    cal("03")

    ##          2018        
    ## 
    ##         March                                                                            
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##              1  2  3                                                                     
    ##  4  5  6  7  8  9 10                                                                     
    ## 11 12 13 14 15 16 17                                                                     
    ## 18 19 20 21 22 23 24                                                                     
    ## 25 26 27 28 29 30 31                                                                     
    ## 

    cal("Jan")

    ##          2018        
    ## 
    ##        January                                                                           
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##     1  2  3  4  5  6                                                                     
    ##  7  8  9 10 11 12 13                                                                     
    ## 14 15 16 17 18 19 20                                                                     
    ## 21 22 23 24 25 26 27                                                                     
    ## 28 29 30 31                                                                              
    ## 

    cal("december")

    ##          2018        
    ## 
    ##       December                                                                           
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##                    1                                                                     
    ##  2  3  4  5  6  7  8                                                                     
    ##  9 10 11 12 13 14 15                                                                     
    ## 16 17 18 19 20 21 22                                                                     
    ## 23 24 25 26 27 28 29                                                                     
    ## 30 31

    cal("2:5")

    ##                                            2018                                           
    ## 
    ##       February                 March                  April                   May        
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##              1  2  3                1  2  3    1  2  3  4  5  6  7          1  2  3  4  5
    ##  4  5  6  7  8  9 10    4  5  6  7  8  9 10    8  9 10 11 12 13 14    6  7  8  9 10 11 12
    ## 11 12 13 14 15 16 17   11 12 13 14 15 16 17   15 16 17 18 19 20 21   13 14 15 16 17 18 19
    ## 18 19 20 21 22 23 24   18 19 20 21 22 23 24   22 23 24 25 26 27 28   20 21 22 23 24 25 26
    ## 25 26 27 28            25 26 27 28 29 30 31   29 30                  27 28 29 30 31      
    ## 

    cal("-r 4")

    ##                                            2018                                           
    ## 
    ##         March                  April                   May                   June        
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##              1  2  3    1  2  3  4  5  6  7          1  2  3  4  5                   1  2
    ##  4  5  6  7  8  9 10    8  9 10 11 12 13 14    6  7  8  9 10 11 12    3  4  5  6  7  8  9
    ## 11 12 13 14 15 16 17   15 16 17 18 19 20 21   13 14 15 16 17 18 19   10 11 12 13 14 15 16
    ## 18 19 20 21 22 23 24   22 23 24 25 26 27 28   20 21 22 23 24 25 26   17 18 19 20 21 22 23
    ## 25 26 27 28 29 30 31   29 30                  27 28 29 30 31         24 25 26 27 28 29 30
    ##                                                                                          
    ##         July                                                                             
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##  1  2  3  4  5  6  7                                                                     
    ##  8  9 10 11 12 13 14                                                                     
    ## 15 16 17 18 19 20 21                                                                     
    ## 22 23 24 25 26 27 28                                                                     
    ## 29 30 31                                                                                 
    ## 

    cal("-r -3")

    ## 
    ##     December 2017          January 2018           February 2018           March 2018     
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##                 1  2       1  2  3  4  5  6                1  2  3                1  2  3
    ##  3  4  5  6  7  8  9    7  8  9 10 11 12 13    4  5  6  7  8  9 10    4  5  6  7  8  9 10
    ## 10 11 12 13 14 15 16   14 15 16 17 18 19 20   11 12 13 14 15 16 17   11 12 13 14 15 16 17
    ## 17 18 19 20 21 22 23   21 22 23 24 25 26 27   18 19 20 21 22 23 24   18 19 20 21 22 23 24
    ## 24 25 26 27 28 29 30   28 29 30 31            25 26 27 28            25 26 27 28 29 30 31
    ## 31

    cal("-r -3:4")

    ## 
    ##     December 2017          January 2018           February 2018           March 2018     
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##                 1  2       1  2  3  4  5  6                1  2  3                1  2  3
    ##  3  4  5  6  7  8  9    7  8  9 10 11 12 13    4  5  6  7  8  9 10    4  5  6  7  8  9 10
    ## 10 11 12 13 14 15 16   14 15 16 17 18 19 20   11 12 13 14 15 16 17   11 12 13 14 15 16 17
    ## 17 18 19 20 21 22 23   21 22 23 24 25 26 27   18 19 20 21 22 23 24   18 19 20 21 22 23 24
    ## 24 25 26 27 28 29 30   28 29 30 31            25 26 27 28            25 26 27 28 29 30 31
    ## 31                                                                                       
    ##      April 2018              May 2018               June 2018              July 2018     
    ## Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
    ##  1  2  3  4  5  6  7          1  2  3  4  5                   1  2    1  2  3  4  5  6  7
    ##  8  9 10 11 12 13 14    6  7  8  9 10 11 12    3  4  5  6  7  8  9    8  9 10 11 12 13 14
    ## 15 16 17 18 19 20 21   13 14 15 16 17 18 19   10 11 12 13 14 15 16   15 16 17 18 19 20 21
    ## 22 23 24 25 26 27 28   20 21 22 23 24 25 26   17 18 19 20 21 22 23   22 23 24 25 26 27 28
    ## 29 30                  27 28 29 30 31         24 25 26 27 28 29 30   29 30 31            
    ## 

    cal("03 2015")

    ##          2015        
    ## 
    ##         March                                                                            
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##  1  2  3  4  5  6  7                                                                     
    ##  8  9 10 11 12 13 14                                                                     
    ## 15 16 17 18 19 20 21                                                                     
    ## 22 23 24 25 26 27 28                                                                     
    ## 29 30 31                                                                                 
    ## 

    cal("Jan 2015")

    ##          2015        
    ## 
    ##        January                                                                           
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##              1  2  3                                                                     
    ##  4  5  6  7  8  9 10                                                                     
    ## 11 12 13 14 15 16 17                                                                     
    ## 18 19 20 21 22 23 24                                                                     
    ## 25 26 27 28 29 30 31                                                                     
    ## 

    cal("January 2015")

    ##          2015        
    ## 
    ##        January                                                                           
    ## Su Mo Tu We Th Fr Sa                                                                     
    ##              1  2  3                                                                     
    ##  4  5  6  7  8  9 10                                                                     
    ## 11 12 13 14 15 16 17                                                                     
    ## 18 19 20 21 22 23 24                                                                     
    ## 25 26 27 28 29 30 31                                                                     
    ## 

Contact
=======

You are welcome to:  
- submit suggestions and bug-reports at:
<https://github.com/trinker/cal/issues>  
- send a pull request on: <https://github.com/trinker/cal>  
- compose a friendly e-mail to: <tyler.rinker@gmail.com>
