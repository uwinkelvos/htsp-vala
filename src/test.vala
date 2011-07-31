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
   public abstract FTypeID FType { get; }
   public abstract string to_string ();
}

class FieldMap : HashMap<string, Field>, Field {
   
   public FieldMap() {
      base();
   }
   
   public FTypeID FType {
      get { return FTypeID.MAP; }
   }

   public string to_string () {
      var len = this.size;
      return @"<elements #: $len>";
   }
}

class FieldLst : ArrayList<Field>, Field {
   
   public FieldLst () {
      base();
   }
   
   public FTypeID FType {
      get { return FTypeID.LST; }
   }

   public string to_string () {
      var len = this.size;
      return @"<elements #: $len>";
   }
}

class FieldS64 : Object, Field {
   int64 data;
   
   public FieldS64(int64 data) {
      this.data = data;
   }
      
   public FTypeID FType {
      get { return FTypeID.S64; }
   }
   
   public string to_string () {
      return data.to_string();
   }

   public int64 Data {
      get { return data; }
      set { this.data = value; }
   }
}

class FieldStr : Object, Field {
   string data;
   
   public FieldStr (string data) {
      this.data = data;
   }
   
   public FTypeID FType {
      get { return FTypeID.STR;}
   }

   public string to_string () {
      return data;
   }

   public string Data {
      get { return data; }
      set { this.data = value; }
   }
}

class FieldBin : Object, Field {
   uint8[] data;

   public FieldBin (uint8[] data) {
      this.data = data;
   }

   public FTypeID FType {
      get { return FTypeID.BIN; }
   }
   
   public string to_string () {
      var len = data.length.to_string();
      return @"<elements #: $len>";
   }
   
   public uint8[] Data {
      get { return data; }
      set {data = value; }
   }
}

class Message : Object {
   
}

