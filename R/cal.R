#' Command Line Calendar
#'
#' A command line calendar in the style of the \pkg{Unix} \pkg{cal} command
#' line tool though with only only flag.
#'
#' @param cmd A string in the form of Month (int/char) AND/OR Year (4 digits).
#' Below are the forms that are accepted:
#' \describe{
#'   \item{2017}{A full calendar for the year}
#'   \item{03}{A single month view}
#'   \item{Jan}{A single month view (case insensitive)}
#'   \item{January}{A single month view (case insensitive)}
#'   \item{2:5}{A multi month view (integers must be > 0 and < 13)}
#'   \item{-r 4}{A multi month view relative to the current month (curent month + n more; integers must be positive and < 13)}
#'   \item{-r -3:4}{A multi month view relative to the current month (curent month +/- n before/after; -r tag not required; lower must be negative; must be less than or equal to 12 months all together)}
#'   \item{03 2015}{A single month view for a particular year}
#'   \item{Jan 2015}{A single month view for a particular year (case insensitive)}
#'   \item{January 2015}{A single month view for a particular year (case insensitive)}
#' }
#' The default is \code{'-r 2'} which prints this month and the next 2.
#' @param ncols The number of columns to form the print grid.  This can be set
#' globally via \code{options(cal.ncols = 4)}
#' @param \ldots ignored.
#' @return Prints calendar to the command line.
#' @references \url{https://www.tutorialspoint.com/unix_commands/cal.htm}
#' @export
#' @examples
#' cal()
#' cal("2017")
#' cal("03")
#' cal("Jan")
#' cal("december")
#' cal("2:5")
#' cal("-r 4")
#' cal("-r -3")
#' cal("-r -3:4")
#' cal("03 2015")
#' cal("Jan 2015")
#' cal("January 2015")
cal <- function(cmd = '-r 2', ncols = NULL, ...){

    if (cmd == '0') cmd <- '-r 0'

    year_month <- parse_cmd(cmd)
    include.year <- length(unique(year_month$year)) == 1

    cells <- stats::setNames(
        Map(
            function(a, b){get_days(a, b, include.year = !include.year)},
            year_month$month,
            year_month$year
        ),
        year_month$year
    )

    if (length(cells) == 0) stop('Could not parse the `cmd`.  See `?cal` for proper formatting', call. = FALSE)

    out <- list(
        cells = cells,
        year_header = include.year,
        year = ifelse(include.year, year_month$year[1], NA)
    )

    class(out) <- 'cal'
    attributes(out)[['ncols']] <- ncols
    out
}






#' Prints a cal Object
#'
#' Prints a cal object
#'
#' @param x A cal Object
#' @param ncols The number of columns to form the print grid
#' @param \ldots ignored
#' @method print cal
#' @export
print.cal <- function(x, ncols = getOption("pax.ncols"), ...){

    if (is.null(ncols) && !is.null(attributes(x)[['ncols']])) {
        ncols <- attributes(x)[['ncols']]
    }

    if (is.null(ncols)) {
        width <- getOption('width')
        ncols <- 1 + floor((width - 20)/23)
    }

    len <- length(x[['cells']])
    nrows <- ceiling(len/ncols)

    fills <- lapply(seq_len((ncols * nrows) - len), function(i) blank)

    cells <- unlist(list(x[['cells']], fills), recursive = FALSE)

    if(x[['year_header']]) {

        header <- x[['year']]

        calwidth <- (min(ncols, len) * 23) - 2
        space <- calwidth - nchar(header)

        header <- paste(c(paste(c(
            paste(rep(' ', ceiling((calwidth - nchar(header))/2)), collapse = ''),
            header,
            paste(rep(' ', floor((calwidth - nchar(header))/2)), collapse = '')
        ), collapse = ''), ''), collapse = '\n')

    } else {
        header <- NULL
    }

    out <- paste(unlist(lapply(
        split(cells, rep(seq_len(nrows), each = ncols)),
        function(x){
            paste(unlist(apply(data.frame(lapply(x, c)), 1, paste, collapse = '   ')), collapse ='\n')

        }
    )), collapse = '\n')

    cat(header, out, sep = '\n')
}

## A constant for adding blank cells
blank <- rep(paste(rep(' ', 20), collapse = ''), 8)



# test_str <- c(
#     ## entire year
#     '2018',
#
#     ## multiple months (fail this later if > 12 output)
#     '-r 3',
#     '-r -3',
#     '-r -3:4',
#     '-2:4',
#     '4:5',
#
#     ## single months
#     '01',
#     '1',
#     'Jan',
#     'feb',
#     'March',
#     'december',
#
#     ## month year
#     '01 2018',
#     '1 2018',
#     'Jan 2018',
#     'feb 2018',
#     'March 2018',
#     'december 2018',
#
#     NA,
#     'sd ds',
#     '123',
#     '0',
#     'dece'
# )




## regex checks
##=============
r_relative_num <- '-r\\s+-*\\d{1,2}'
r_relative_vect <- '(-r\\s+)?-\\d{1,2}:\\d{1,2}'

## convert first 2 with look up table
r_month_abb <- paste0('(', paste(tolower(month.abb), collapse = '|'), ')')
r_month_name <- paste0('(', paste(tolower(month.name), collapse = '|'), ')')
r_month_num <- '(0?[1-9]|1[012])'
r_months_num <- '\\d{1,2}:\\d{1,2}'

## strip r eval
r_year <- '\\d{4}'


regex_forms <- stats::setNames(
    as.list(paste0('^(', c(
        paste(c(r_month_abb, r_month_name, r_month_num), r_year),
        r_relative_num,
        r_relative_vect,
        r_month_abb,
        r_month_name,
        r_month_num,
        r_months_num,
        r_year
    ), ')$')),
    c(
        paste(c('r_month_abb', 'r_month_name', 'r_month_num'), 'year', sep ='_'),
        "r_relative_num", "r_relative_vect", "r_month_abb", "r_month_name", "r_month_num", "r_months_num", "r_year"
    )
)


## function to parse the cmd string
parse_cmd <- function(cmd, ...){

    cmd <- tolower(cmd)
    type <- get_cmd_type(cmd)

    cmonth <- as.integer(format(Sys.Date(), format = '%m'))
    cyear <- as.integer(format(Sys.Date(), format = '%Y'))

    ## return = list(months, years), parse m/y add m/y where missing
    switch(type,

        r_month_abb_year = {

            list(
                year = as.integer(gsub('(^[^ ]+\\s+)(\\d{4}$)', '\\2', cmd)),
                month = match(gsub('(\\s+\\d{4}$)', '', cmd), tolower(month.abb))
            )

        },

        r_month_name_year = {

            list(
                year = as.integer(gsub('(^[^ ]+\\s+)(\\d{4}$)', '\\2', cmd)),
                month = match(gsub('(\\s+\\d{4}$)', '', cmd), tolower(month.name))
            )

        },

        r_month_num_year = {

            list(
                year = as.integer(gsub('(^\\d{1,2}\\s+)(\\d{4}$)', '\\2', cmd)),
                month = as.integer(gsub('(^\\d{1,2})(\\s+\\d{4}$)', '\\1', cmd))
            )

        },

        r_relative_num = {

            months <- 0:eval(parse(text = gsub('-r\\s+', '', cmd)))
            months2 <- sort(cmonth + months)

            list(
                year = c(
                    rep(cyear - 1, length(months2[months2 <= 0])),
                    rep(cyear, length(months2[months2 > 0 & months2 < 13])),
                    rep(cyear + 1, length(months2[months2 > 12]))
                ),
                month = c(
                    12 - abs(months2[months2 <= 0]),
                    months2[months2 > 0 & months2 < 13],
                    months2[months2 > 12] - 12
                )
            )

        },

        r_relative_vect = {

            months <- eval(parse(text = gsub('-r\\s+', '', cmd)))
            if (length(months) > 12) stop('Number of months must be less or equal to 12.', call. = FALSE)

            months2 <- cmonth + months

            list(
                year = c(
                    rep(cyear - 1, length(months2[months2 <= 0])),
                    rep(cyear, length(months2[months2 > 0 & months2 < 13])),
                    rep(cyear + 1, length(months2[months2 > 12]))
                ),
                month = c(
                    12 - abs(months2[months2 <= 0]),
                    months2[months2 > 0 & months2 < 13],
                    months2[months2 > 12] - 12
                )
            )

        },

        r_month_abb = {

            months <- match(cmd, tolower(month.abb))

            list(
                year = rep(cyear, length(months)),
                month = months
            )

        },

        r_month_name = {

            months <- match(cmd, tolower(month.name))

            list(
                year = rep(cyear, length(months)),
                month = months
            )

        },

        r_month_num = {

            list(
                year = cyear,
                month = as.integer(cmd)
            )

        },

        r_months_num = {

            months <- eval(parse(text = cmd))
            if (length(months) > 12) stop('Number of months must be less or equal to 12.', call. = FALSE)
            if (max(months) > 12 | min(months) < 1) stop('Month itnegers cannot be > 12 or < 1', call. = FALSE)

            list(
                year = rep(cyear, length(months)),
                month = months
            )

        },

        r_year = {

            list(
                year = rep(as.integer(cmd), 12),
                month = 1:12
            )

        },

        stop('`cmd` was not a valid format.  Use `?cal` to see valid formats for `cmd`.', call. = FALSE)
    )

}


## short cut for grepl to validate strings (detect if a regex cond is matched)
validator <- function(str, reg) grepl(reg, str, ignore.case = TRUE)

## function to determine which of the cal formats that cmd is
get_cmd_type <- function(cmd, regs = regex_forms, ...){

    unlist(lapply(cmd, function(x){

        out <- unlist(lapply(regs, function(y) validator(x, y)))
        out <- names(out)[out]
        if (length(out) == 0) out <- NA
        out

    }))
}



## function to grab the days of a month and format them for that year
get_days <- function(month = NULL, year = NULL, include.year = FALSE, ...){

    if (is.null(month)) {
        month <- as.integer(format(Sys.Date(), format = '%m'))
    }
    if (is.null(year)) {
        year <- as.integer(format(Sys.Date(), format = '%Y'))
    }

    ## number of days and start day of week
    start_date <- as.Date(sprintf('%s-%s-01', year, month))
    days <- stringi::stri_pad(
        seq_len(lubridate::days_in_month(start_date)),
        width = 2,
        side = 'left',
        pad = ' '
    )

    start_dow <- weekdays(start_date)

    front_fills <- rep('  ', lubridate::wday(start_date) - 1)

    days_filled <- c(front_fills, days)
    days_filled <- c(days_filled, rep('  ', 42 - length(days_filled)))

    out <- apply(matrix(days_filled, ncol = 7, byrow = TRUE), 1, paste, collapse = ' ')
    month <- format(start_date, format = '%B')

    if (include.year) month <- paste(month, year)

    out <- c(
        paste(c(
            paste(rep(' ', ceiling((nchar(out[1]) - nchar(month))/2)), collapse = ''),
            month,
            paste(rep(' ', floor((nchar(out[1]) - nchar(month))/2)), collapse = '')
        ), collapse = ''),
        paste(c('Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'), collapse = ' '),
        out
    )

    class(out) <- 'calmonth'
    out
}

