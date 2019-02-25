context("test-venues")

test_that("Venues scrape", {
  q <- getVenue()
  
  expect_equal(names(q), c("copyright", "venues"))
  
  q <- getVenue(5017)
  
  expect_equal(names(q), c("copyright", "venues"))
  expect_match(q$venues$name, "Amalie Arena")
  
  # Expect Failures
  expect_error(getVenue(c(1, 2)))
  expect_error(getVenue("Scotiabank"))
  
})
