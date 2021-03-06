context("partial_eval")

test_that("subsetting always evaluated locally", {
  x <- list(a = 1, b = 1)
  y <- c(2, 1)
  correct <- quote(`_var` == 1)

  expect_equal(partial_eval(quote(`_var` == x$a)), correct)
  expect_equal(partial_eval(quote(`_var` == x[[2]])), correct)
  expect_equal(partial_eval(quote(`_var` == y[2])), correct)
})

test_that("namespace operators always evaluated locally", {
  expect_equal(partial_eval(quote(base::sum(1, 2))), 3)
  expect_equal(partial_eval(quote(base:::sum(1, 2))), 3)
})

test_that("namespaced calls to dplyr functions are stripped", {
  expect_equal(partial_eval(quote(dplyr::n())), expr(n()))
})

test_that("use quosure environment for unevaluted formulas", {
  x <- 1
  expect_equal(partial_eval(expr(~x)), ~1)
})
