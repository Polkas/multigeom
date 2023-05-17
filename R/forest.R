#' Forest Plot Geom
#' @keywords internal
GeomForest <- ggplot2::ggproto("GeomForest", ggplot2::Geom,
                               required_aes = c("x", "y", "xmin", "xmax"),
                               default_aes = ggplot2::aes(
                                 colour = "black",
                                 linewidth = .5,
                                 line_size = 1,
                                 point_size = 2,
                                 linetype = 1,
                                 shape = 19,
                                 fill = NA,
                                 alpha = NA,
                                 height = 0.5,
                                 stroke = 1
                               ),
                               setup_data = function(data, params) {
                                 if (is.null(data$height)) {
                                   if (is.null(params$height)) {
                                     data$height <- ggplot2::resolution(data$y, FALSE) * 0.9
                                   } else {
                                     data$height <- params$height
                                   }
                                 }
                                 transform(data,
                                           ymin = y - height / 2,
                                           ymax = y + height / 2,
                                           height = NULL
                                 )
                               },
                               draw_panel = function(data, panel_params, coord, ...) {
                                 grid::gList(
                                   ggplot2::GeomErrorbarh$draw_panel(transform(data, size = line_size, linewidth = linewidth), panel_params, coord, ...),
                                   ggplot2::GeomPoint$draw_panel(transform(data, size = point_size), panel_params, coord, ...)
                                 )
                               }
)

#' Forest Plot Geom
#' @inheritParams ggplot2::geom_errorbarh
#' @inheritParams ggplot2::geom_point
#' @export
#' @examples
#' df <- data.frame(x = 1:10, y = 1:10, xmin = -2 * 2:11, xmax = 2 * 2:11)
#' base <- ggplot2::ggplot(
#'   df,
#'   ggplot2::aes(x = x, y = y, xmin = xmin, xmax = xmax, point_size = x)
#' )
#' base + multigeom::geom_forest()
geom_forest <- function(mapping = NULL, data = NULL,
                        stat = "identity", position = "identity",
                        ..., na.rm = FALSE, show.legend = NA,
                        inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomForest,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
