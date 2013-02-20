
// rename screenshots when quitting; a rather ugly solution, but works great
// via: https://forum.processing.org/topic/run-code-on-exit
void prepareExitHandler () {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      try {
        File dir = new File(screenshotFolder);
        println(dir.getAbsolutePath());
        if (dir.isDirectory()) {
          for (File f : dir.listFiles()) {
            
            if (f.getName().startsWith(".")) {
              continue;
            }
            
            // LawAndOrder-01-00_01_27-0001.png
            // 0 = full path + /LawAndOrder
            // 1 = episode # on disc
            // 2 = time in HH_MM_SS
            // 3 = number and extension
            println(f.getAbsolutePath());
            String[] s = split(f.getAbsolutePath(), "-");
            String[] t = split(s[2], "_");
            String time = t[0] + "h" + t[1] + "m" + t[2] + "s";
            File newFilename = new File(s[0] + "_Season" + season + "_Episode" + episode + "_" + time + "_" + s[3]);
            f.renameTo(newFilename);
          }
        }
        else {
          println("not dir");
        }
        stop();
      } 
      catch (Exception ex) {
        ex.printStackTrace();     // not much else to do at this point...
      }
    }
  }
  ));
}
