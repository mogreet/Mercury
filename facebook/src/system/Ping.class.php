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

include_once(dirname(__FILE__) . '/../Response.class.php');

/**
* The Ping object contains the response from a {@link Mercury#ping} request to the Moms API.
*/
class Ping extends Response 
{
    /** 
    * Construct the Ping object by parsing the XML.
    * @param xml_doc the DOM XML document
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);
    }
}

?>
