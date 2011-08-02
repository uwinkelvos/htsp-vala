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
      root["int64"] = new FieldS64 (0xff000000);
      root["int32"] = new FieldS64 (0x00ff0000);
      root["int16"] = new FieldS64.bin ({0x5,0x39});
      root["int8"] = new FieldS64  (0x000000ff);
      root["string"] = new FieldStr ("hüllö");
      root["bin"] = new FieldBin ({1,2,3,4,5});
      root["list"] = new FieldLst ();
      
      foreach (var key in root.keys) {
         var field = root[key];
         stdout.printf ("[%s]%s: %s\n", field.f_type.to_string (), key, field.to_string());
      }
      
      ((FieldS64)root["int16"]).to_bin();
      ((FieldStr)root["string"]).to_bin();
      stdout.printf ("root-size: %i\n", root.f_size);
      
      uint8[] bar = new uint8[100];
      MemoryOutputStream mout;
      mout = new MemoryOutputStream(bar, null, free );
      mout.write({'a','b','c'});
      stdout.printf("%s\n", (string)mout.get_data());
      
      return 0;
   }
}

