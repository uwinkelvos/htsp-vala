using GLib;
using Gee;

public enum FTypeID {
   ERR = 0, // this is only necessary to sattisfy the runtime checks...
   MAP = 1,
   S64 = 2,
   STR = 3,
   BIN = 4,
   LST = 5;
   
   public string to_string () {
      switch(this) {
         case FTypeID.MAP:
            return "MAP";
         case FTypeID.S64:
            return "S64";
         case FTypeID.STR:
            return "STR";
         case FTypeID.BIN:
            return "BIN";
         case FTypeID.LST:
            return "LST";
         default:
            return "ERROR";
      }
   }
}

public abstract interface Field : Object {
   public abstract FTypeID f_type { get; }
   public abstract string to_string ();
   public abstract uint8[] to_bin ();
   public abstract int f_size { get; }
}


//TODO: inhertigae ois probably not the way to go for Map and List. Containers should be add only
class FieldMap : HashMap<string, Field>, Field {
   
   public FieldMap() {
      base();
   }
   
   public FTypeID f_type {
      get { return FTypeID.MAP; }
   }

   public string to_string () {
      var len = this.f_size;
      return @"<elements #: $len>";
   }
   
   public uint8[] to_bin () {
      //TODO: TBD!
      return new uint8[0];
   }
   
   public int f_size {
      get {
         int size = 0;
         foreach (var key in this.keys) {
            var field = this[key];
            size += field.f_size; 
         }
         return size;
      }
   }
}

class FieldLst : ArrayList<Field>, Field {
   
   public FieldLst () {
      base();
   }
   
   public FTypeID f_type {
      get { return FTypeID.LST; }
   }

   public string to_string () {
      var len = this.f_size;
      return @"<element : $len>";
   }

   public uint8[] to_bin () {
      //TODO: TBD!
      return new uint8[0];
   }

   public int f_size {
      get {
         int size = 0;
         foreach (var field in this) {
            size += field.f_size; 
         }
         return size;
      }
   }
}

class FieldS64 : Object, Field {
   int64 _data;
   
   public FieldS64(int64 _data) {
      this._data = _data;
   }
   public FieldS64.bin (uint8[] bin) {
      // btw are value types initialized be def.?
      _data = 0;
      for (var i = 0; i < bin.length; i++) {
         _data <<= 8;
         _data |= bin[i]; 
      }
   }

   public FTypeID f_type {
      get { return FTypeID.S64; }
   }
   
   public string to_string () {
      return @"$(_data.to_string()) [$(this.f_size) B]";
   }

   public int64 data {
      get { return _data; }
      //set { this._data = value; }
   }
   
   public uint8[] to_bin () {
      
      // are there any fancy memstream classes?
      
      var max = this.f_size;
      uint8[] bin = new uint8[max];

      for (var i = 0; i < max; i++) {
         // is this bad? blah << -8
         bin[i] = (uint8)(_data >> ((max - 1 - i) * 8));
      }
            
      return bin;
   }
   
   public int f_size {
      get {
      // this could be cached :)
         var tmp = _data;
         var _size = 0;
         while (tmp != 0) {
            tmp = tmp >> 8;
            _size++;
         }
         return _size;
      }
   }
}

class FieldStr : Object, Field {
   string _data;
   
   public FieldStr (string _data) {
      this._data = _data;
   }
   
   public FieldStr.bin (uint8[] bin) {
      
      _data = (string)bin;
   }
   
   public FTypeID f_type {
      get { return FTypeID.STR; }
   }

   public string to_string () {
      return @"$(_data) [$(this.f_size) B]";
   }

   public string data {
      get { return _data; }
      //set { this._data = value; }
   }

   public uint8[] to_bin () {
      return _data.data;
   }

   public int f_size {
      get { return (int)_data.length; }
   }   
}

class FieldBin : Object, Field {
   uint8[] _data;

   public FieldBin (uint8[] _data) {
      this._data = _data;
   }

   // consistency
   public FieldBin.bin (uint8[] _data) {
      this._data = _data;
   }

   public FTypeID f_type {
      get { return FTypeID.BIN; }
   }
   
   public string to_string () {
      var len = _data.length.to_string();
      return @"<elements #: $len> [$(this.f_size) B]";
   }
   
   public uint8[] to_bin () {
      return _data;
   }

   public uint8[] data {
      get { return _data; }
      //set { _data = value; }
   }
   
   public int f_size {
      get { return (int)_data.length; }
   }
}

class Message : Object {
   
}

