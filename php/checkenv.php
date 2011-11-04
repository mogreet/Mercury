<?php

/**
* Copyright 2011 Jonathan Perichon <jonathan.perichon@gmail.com>
*
* This file is part of Mercury.
*
* Mercury is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Mercury is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury.  If not, see <http://www.gnu.org/licenses/>.
*/

echo "<table><tr><td>curl</td><td>";
if (extension_loaded ("curl")) {
   echo "<div style='color: green;'>OK</div>";
} else {
   echo "<div style='color: red;'>NOT OK</div>";
}
echo "</td></tr><tr><td>mod_php5</td><td>";
if (in_array("mod_php5", apache_get_modules())) {
    echo "<div style='color: green;'>OK</div>";
} else {
    echo "<div style='color : red;'>NOT OK</div>";
}
echo "</td></tr></table>";

?>