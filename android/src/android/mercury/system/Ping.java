/**
* Copyright 2011 Julien Salvi for Mogreet
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
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury. If not, see <http://www.gnu.org/licenses/>.
*/

package android.mercury.system;

import org.w3c.dom.Document;

import android.mercury.*;

/**
 * 
 * Send a PING request to the MOMs API.
 *
 */
public class Ping extends Response {

	/**
	 * Creation of a new Ping response.
	 * @param xmlDoc XML DOM document 
	 */
	public Ping(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
	}
}
