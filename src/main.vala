/* main.vala
 *
 * Copyright (C) 2010  
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *  
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Author:
 * 	 <>
 */

using GLib;
using Gee;

public class Main : Object {
   public Main () {
   }

   static int main (string[] args) {
      
      var root = new FieldMap ();
      root["map"] = new FieldMap ();
      root["int64"] = new FieldS64 (12);
      root["string"] = new FieldStr ("hello");
      root["bin"] = new FieldBin ({1,2,3,4,5});
      root["list"] = new FieldLst ();
      
      foreach (var key in root.keys) {
         var field = root[key];
         stdout.printf ("[%s]%s: %s\n", field.FType.to_string (), key, field.to_string());
      }
      
      return 0;
   }
}

