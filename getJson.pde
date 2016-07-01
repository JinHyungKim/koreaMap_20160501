

class getJson implements Runnable {
  
  JSONObject json;
  
  getJson() {
    Thread thread = new Thread(this);
    thread.start();
  }
  
  public void run()  {
  
  json = loadJSONObject("nabi.json");

  JSONArray values = json.getJSONArray("animal");
  
  float min;
  float max;
  
  min=1800;
  max=0;
  
  color_c=new int[(values.size())];
  color_v=new int[(values.size())];
  color_l=values.size();
  
  for (int i = 0; i < values.size(); i++) {
    
    JSONObject line = values.getJSONObject(i); 

    String local_main=line.getString("local_main");
    String local_sub=line.getString("local_sub");
    int timestamp=line.getInt("timestamp");
    //float mwh_5m=line.getFloat("usage_5min_MWh");
    //String code=line.getString("code");
    color_c[i]=line.getInt("code");    
    color_v[i]=int(line.getFloat("usage_5min_MWh")/1900*100);
    
    /*
    if(min>mwh_5m)  {
        min=mwh_5m;
    }
    if(max<mwh_5m)  {
        max=mwh_5m;
    }
   
   if(code.substring(0,2).equals("11"))  {
    print(local_main + "," + local_sub + "," + timestamp + "," + code + "," + mwh_5m +"\n");
   }
    
    switch(code)  {
      case "11740":
      print(local_sub);
      break;
    } 
  }
  print("min:"+min+", max:"+max);
  
  // max:1805
  */
  }
}
}