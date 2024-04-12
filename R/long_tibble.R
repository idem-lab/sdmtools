library(tibble)

long_tibble <- setClass(
  Class = "long_tibble",
  slots = c(tab = "tbl_df"),
  contains = "tbl_df"
)

print.long_tibble <- function(x){
  x@tab |>
    tibble::as_tibble() |>
    print(n = 3)
}

zz <- tibble::tibble(a = 1:10)
class(zz) <- "long_tibble"
zz

xx <- long_tibble(tab = zz)
zz


long_tibble <- setClass(
  +   Class = "long_tibble",
  +   #slots = c(tab = "tbl_df"),
    +   contains = "tbl_df"
  + )
print.long_tibble <- function(x){
  +   print(x, n = 3)
  + }

xx <- setClass("xx", slots = c("tbl_df"))
zz <- tibble::tibble(a = 1:10)
class(zz) <- "xx"
print.xx <- function(z){z$a |> tibble::as_tibble() |> print(n = 3)}
zz


xx <- setClass("xx", slots = c("tbl_df"))
zz <- tibble::tibble(a = 1:10)
class(zz) <- "xx"
print.xx <- function(z){z |> tibble::as_tibble() |> print(n = 3)}
zz
