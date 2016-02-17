#' glcfsCheatSheet
#'
#' glcfsCheatSheet shows abbrieviations need in parameter file for glcfs data
#'
#' @return baseURL string
#' @export
#' @examples
#' baseReturn <- glcfsCheatSheet()
glcfsCheatSheet <- function(){
  
  message("Ice Concentration = ci\n",
          "Height Above Model Sea Level = eta\n",
          "Ice Thickness = hi\n",
          "Eastward Water Velocity at Surface = uc\n",
          "Ice u-Velocity = ui\n",
          "Depth-Averaged Eastward Water Velocity = utm\n",
          "Northward Water Velocity at Surface = vc\n",
          "Ice v-Velocity = vi\n",
          "Depth-Averaged Northward Water Velocity = vtm\n",
          "Wave Direction = wvd\n",
          "Significant Wave Height = wvh\n",
          "Wave Period = wvp\n",
          "Eastward Air Velocity = air_u\n",
          "Northward Air Velocity = air_v\n",
          "Air Temperature = at\n",
          "Cloud Cover = cl\n",
          "Dew Point = dp\n",
          "Sea Water Temperature = temp\n",
          "Eastward Water Velocity = u\n",
          "Northward Water Velocity = v\n")
}