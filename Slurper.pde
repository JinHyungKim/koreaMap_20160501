// Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.

    // Indices for each of the columns
    int ZIP_CODE = 0;
    int LATITUDE = 1;
    int LONGITUDE = 2;
    int PONAME = 3;
    int COLOR = 4;
    

class Slurper implements Runnable {

  Slurper() {
    Thread thread = new Thread(this);
    thread.start();
  }

  public void run() {
      
      
      String[] lines=loadStrings("zips.csv");
      
      
      // Set the minimum and maximum values arbitrarily large.
      float minX = 1;
      float maxX = -1;
      float minY = 1;
      float maxY = -1;
  
      String[] cleaned=new String[lines.length];
  
      int totalCount=0;
      
      for(int row=1;row<lines.length;row++)
      {
        totalCount++;
      }
      places = new Place[totalCount];
      
  
      for(int row=1;row<lines.length;row++)
      {
          String[] data=split(lines[row],',');
 
          float lat = float(data[LATITUDE]);
          float lon = float(data[LONGITUDE]);

          // Albers equal-area conic projection.
          // USGS uses standard parallels at 45.5 ̊N and 29.5 ̊N
          // with a central meridian value of 96 ̊W.
          // Latitude value is phi, longitude is lambda.
          float phi0 = 0;
          float lambda0 = radians(127);
          float phi1 = radians(37.4f);
          float phi2 = radians(37.8f);
          float phi = radians(lat);
          float lambda = radians(lon);
          float n = 0.5f * (sin(phi1) + sin(phi2));
          float theta = n * (lambda - lambda0); //radians(lon - lambda0);
          float c = sq(cos(phi1)) + 2*n*sin(phi1);
          float rho = sqrt(c - 2*n*sin(phi)) / n;
          float rho0 = sqrt(c - 2*n*sin(phi0)) / n;
          float x = rho * sin(theta);
          float y = rho0 - rho*cos(theta);
 
          if (x > maxX) maxX = x;
          if (x < minX) minX = x;
          if (y > maxY) maxY = y;
          if (y < minY) minY = y;
  
          places[placeCount]=parsePlace(Integer.parseInt(data[ZIP_CODE]),x,y,data[PONAME],data[COLOR]);
  
          placeCount++;
       }
     
      parseInfo(totalCount,minX,maxX,minY,maxY);
         
      }
    
  }