

oldwd <- getwd()
#these tests need to use the test viz
testtmp <- setup(copyTestViz=TRUE)
viz <- as.viz(list(
  depends = c("MayflyNymph", "carData", "plot-info", "exampleSVG", "lakeLoc")
))

context("readData")

test_that("readData works as expected", {

  mayfly <<- readData(viz[['depends']][1])
  carData <<- readData(viz[['depends']][2])
  plotData <<- readData(viz[['depends']][3])
  svg_example <- readData(viz[['depends']][4])
  lakeLoc <- readData(viz[['depends']][5])
  expect_is(mayfly, 'data.frame')
  expect_is(carData, 'list')
  expect_is(carData[[1]], 'data.frame')
  expect_is(carData[[2]], 'data.frame')
  expect_is(plotData, 'list')
  expect_is(svg_example, c('xml_document', 'xml_node'))
  expect_is(lakeLoc, c('SpatialPolygonsDataFrame', 'sp'))
  expect_true(all(names(plotData) %in% c("width", "height")) )
  
})

context("readDepends")
test_that("readDepends works as expected with viz input",{
  viz.dep <- readDepends(viz)
  expect_equal(mayfly, viz.dep[["MayflyNymph"]])
  expect_equal(viz.dep[["carData"]], carData)
})

context("readDepends")
test_that("readDepends works as expected with parameters input",{
  viz.dep <- readDepends(viz)
  expect_equal(plotData, viz.dep[["plot-info"]])
})

test_that("readDepends works as expected with list input",{
  viz.dep <- readDepends(list(
    depends = c("MayflyNymph", "carData")
  ))
  expect_equal(mayfly, viz.dep[["MayflyNymph"]])
  expect_equal(viz.dep[["carData"]], carData)
})

cleanup(oldwd, testtmp)
