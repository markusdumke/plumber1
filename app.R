library(plumber)

server <- plumb("plumber.R")

server$run(
  host = '0.0.0.0',
  port = 80,
  swagger=TRUE
)
