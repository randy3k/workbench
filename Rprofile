.First = function(){
    options(
        repos = c(CRAN = "http://cran.rstudio.com/"),
        browserNLdisabled = TRUE,
        deparse.max.lines = 2,
        help_type="html",
        max.print=1000)

    if (interactive() && .Platform$GUI == "X11" && Sys.getenv("RSTUDIO")==""){
        if ("colorout" %in% rownames(utils::installed.packages())){
            colorout::setOutputColors256(normal = 4, number = 4, negnum = 5,
                               string = 6, const = 2,
                               stderror = 3, warn = 3, error= 1, verbose=FALSE)
        }else if (Sys.getenv("R_colorout")==""){
            Sys.setenv(R_colorout=TRUE)
            library(stats)
            library(utils)
            install.packages("devtools")
            library(devtools)
            install_github("randy3k/colorout")
            Sys.setenv(unset="R_colorout")
        }
    }
}
