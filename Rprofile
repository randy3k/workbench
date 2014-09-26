.First = function(){
    options(
        repos = c(CRAN = "http://cran.rstudio.com/"),
        browserNLdisabled = TRUE,
        deparse.max.lines = 2,
        help_type="html",
        max.print=1000)

    installed = function(pkg){
            pkg %in% rownames(utils::installed.packages())
        }
    if (interactive()) {
        if (installed("colorout") && .Platform$GUI == "X11" && Sys.getenv("RSTUDIO")==""){
            colorout::setOutputColors256(normal = 4, number = 4, negnum = 5,
                               string = 2, const = 6, stderror = 3,
                               warn = 3, error= 1, verbose=FALSE)
        }
    }
}
