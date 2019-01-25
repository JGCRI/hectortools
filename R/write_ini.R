#' Write R list to Hector INI file
#'
#' @param ini_list Hector INI named, nested list, such as that
#'   returned by [read_ini()].
#' @param file Output file, as character string or connection. See
#'   [base::writeLines()].
#' @return `ini_list`, invisibly
#' @author Alexey Shiklomanov
#' @examples
#' l <- list(a = list(a1 = 5, a2 = 3.5),
#'           b = list(some_file = "hello", `b3[50]` = 5))
#' tmp <- tempfile()
#' write_ini(l, tmp)
#' # Write to `stdout()`
#' write_ini(l, "")
#' @export
write_ini <- function(ini_list, file) {
  stopifnot(!is.null(names(ini_list)))
  string <- "; Config file for hector model"
  for (tag in names(ini_list)) {
    string <- c(string, sprintf("[%s]", tag))
    sub_list <- ini_list[[tag]]
    for (key in names(sub_list)) {
      value <- sub_list[[key]]
      if (is.data.frame(value)) {
        string <- c(string,
                    sprintf("%s[%d] = %s", key, value[["date"]],
                            format(value[[key]], scientific = FALSE)))
      } else {
        string <- c(string, sprintf("%s = %s", key,
                                    format(value, scientific = FALSE)))
      }
    }
  }
  writeLines(string, file)
  invisible(ini_list)
}
