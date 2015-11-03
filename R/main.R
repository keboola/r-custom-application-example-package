#' Example custom KBC application in R
#' @import methods
#' @import keboola.r.docker.application
#' @export CustomApplicationExample
#' @exportClass CustomApplicationExample
CustomApplicationExample <- setRefClass(
    'CustomApplicationExample',
    contains = c("DockerApplication"),
    fields = list(),
    methods = list(
        run = function() {
            # intialize application
            readConfig()

            # do something clever
            tables <- getInputTables()
            for (i in 1:nrow(tables)) {
                name <- tables[i, 'destination']

                #read table data
                data <- read.csv(tables[i, 'full_path'])

                # read table metadata
                manifest <- getTableManifest(name)
                if ((length(manifest$primary_key) == 0) && (nrow(data) > 0)) {
                    data[['primary_key']] <- seq(1, nrow(data))
                } else {
                    data[['primary_key']] <- NULL
                }
                names(data) <- paste0('batman_', names(data))

                # read output mapping
                outName <- getExpectedOutputTables()[i, 'full_path']
                outDestination <- getExpectedOutputTables()[i, 'destination']

                # write output data
                write.csv(data, file = outName, row.names = FALSE)

                # write table metadata
                writeTableManifest(outName, destination = outDestination, primaryKey = c('batman_primary_key'))
            }
        }
    )
)
