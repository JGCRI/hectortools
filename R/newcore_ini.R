#' Create a new Hector core from an INI list object
#'
#' Simple wrapper that first writes the INI list object to a file
#' (`tempfile()` by default) and then creates a Hector core for that file.
#'
#' @param ini_list Nested Hector INI configuration list object, such
#'   as that returned by [read_ini()].
#' @param file File path for INI file. Default is [base::tempfile()].
#' @param clean Logical. If `TRUE` (default), remove INI
#' @param ... Additional arguments to [hector::newcore]
#' @return Hector core object (see [hector::newcore()])
#' @export
newcore_ini <- function(ini_list, file = tempfile(), clean = TRUE, ...) {
  on.exit(if (clean) file.remove(file), add = FALSE)
  write_ini(ini_list, file)
  hector::newcore(file, ...)
}
