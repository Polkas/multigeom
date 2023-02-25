#' Barbell Plot Geom
#' @keywords internal
#' @references https://ggplot2-book.org/extensions.html#combining-multiple-geoms
GeomBarbell <- ggplot2::ggproto("GeomBarbell", ggplot2::Geom,
                       required_aes = c("x", "y", "xend", "yend"),
                       default_aes = ggplot2::aes(
                         colour = "black",
                         linewidth = .5,
                         size = 2,
                         linetype = 1,
                         shape = 19,
                         fill = NA,
                         alpha = NA,
                         stroke = 1
                       ),

                       draw_panel = function(data, panel_params, coord, ...) {

                         # Transformed data for the points
                         point1 <- transform(data)
                         point2 <- transform(data, x = xend, y = yend)

                         # Return all three components
                         grid::gList(
                           ggplot2::GeomSegment$draw_panel(data, panel_params, coord, ...),
                           ggplot2::GeomPoint$draw_panel(point1, panel_params, coord, ...),
                           ggplot2::GeomPoint$draw_panel(point2, panel_params, coord, ...)
                         )
                       }
)

#' Barbell Plot Geom
#'
#' @inheritParams ggplot2::geom_segment
#' @inheritParams ggplot2::geom_point
#' @references https://ggplot2-book.org/extensions.html#combining-multiple-geoms
#' @export
#' @examples
#' df <- data.frame(x = 1:10, xend = 0:9, y = 0, yend = 1:10)
#' base <- ggplot2::ggplot(df, ggplot2::aes(x, y, xend = xend, yend = yend))
#'
#' base + multigeom::geom_barbell(shape = 4, linetype = "dashed")
#'
geom_barbell <- function(mapping = NULL, data = NULL,
                         stat = "identity", position = "identity",
                         ..., na.rm = FALSE, show.legend = NA,
                         inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomBarbell,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


